// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram/camera/camera.dart';
import 'package:nutrigram/components/show_food_item.dart';
import 'package:nutrigram/database/firebase_nutrition.dart';
import 'package:nutrigram/theme/app_color.dart';

class NutritionPage extends StatefulWidget {
  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final FirestoreServiceNutrition firestoreService =
      FirestoreServiceNutrition();

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _openCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalGray,
      body: StreamBuilder<DocumentSnapshot>(
          stream: firestoreService.getUserStream('ngiamjw@gmail.com'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              Map<String, dynamic> recommendedNutrition =
                  userData['recommendedNutrition'];

              return FutureBuilder<Map<String, dynamic>>(
                  future: firestoreService.getDailyIntake('ngiamjw@gmail.com',
                      DateFormat('ddMMyyyy').format(DateTime.now())),
                  builder: (context,
                      AsyncSnapshot<Map<String, dynamic>> dailyIntakeSnapshot) {
                    if (dailyIntakeSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    Map<String, dynamic> dailyIntake =
                        dailyIntakeSnapshot.data!;
                    int calories = dailyIntake['caloriesConsumed'];
                    int protein = dailyIntake['proteinConsumed'];
                    int carbs = dailyIntake['carbsConsumed'];
                    int fats = dailyIntake['fatsConsumed'];
                    double calories_percent = (calories /
                            recommendedNutrition['recommendedCalories']) *
                        100;
                    double protein_percent =
                        (protein / recommendedNutrition['recommendedProtein']) *
                            100;
                    double carbs_percent =
                        (carbs / recommendedNutrition['recommendedCarbs']) *
                            100;
                    double fats_percent =
                        (fats / recommendedNutrition['recommendedFats']) * 100;
                    return Stack(
                      children: [
                        // Main ListView to hold all content and make it scrollable
                        ListView(
                          padding: EdgeInsets.all(
                              16), // Space for the ElevatedButton
                          children: [
                            // First Box
                            Container(
                              height: 145,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFF2C2C2E),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 9),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${recommendedNutrition['recommendedCalories']}",
                                              style: TextStyle(
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFFFFFF))),
                                          Text("Calories left",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF8E8E93))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          PieChart(
                                            PieChartData(
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 50,
                                              startDegreeOffset: 270,
                                              sections: [
                                                PieChartSectionData(
                                                  value:
                                                      calories_percent, // Completed portion
                                                  color: Colors.green,
                                                  title: "",
                                                  radius: 7,
                                                  showTitle: true,
                                                ),
                                                PieChartSectionData(
                                                  value: 100 -
                                                      calories_percent, // Remaining portion
                                                  color: Colors.grey,
                                                  title: "",
                                                  radius: 7,
                                                  showTitle: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons
                                                .local_fire_department, // Icon for Calories
                                            color: calories_percent > 100
                                                ? Colors.orange.shade400
                                                : Colors.grey.shade400,
                                            size:
                                                40, // Adjust the size as per your preference
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),

                            // Smaller Boxes
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSmallBox(
                                  "${recommendedNutrition['recommendedProtein']}g",
                                  "Protein left",
                                  protein_percent,
                                  Icon(
                                    Icons.fitness_center, // Icon for Calories
                                    color: Colors.red.shade400,
                                    size:
                                        22, // Adjust the size as per your preference
                                  ),
                                ),
                                _buildSmallBox(
                                  "${recommendedNutrition['recommendedCarbs']}g",
                                  "Carbs left",
                                  carbs_percent,
                                  Icon(
                                    Icons.bakery_dining, // Icon for Calories
                                    color: Colors.blue.shade400,
                                    size:
                                        25, // Adjust the size as per your preference
                                  ),
                                ),
                                _buildSmallBox(
                                  "${recommendedNutrition['recommendedFats']}g",
                                  "Fats left",
                                  fats_percent,
                                  Icon(
                                    Icons.opacity, // Icon for Calories
                                    color: Colors.green.shade400,
                                    size:
                                        23, // Adjust the size as per your preference
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            // Uploaded Today
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Uploaded today",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            // ListView.builder for dynamic content

                            FutureBuilder<List<Map<String, dynamic>>>(
                              future: firestoreService.getFoodItems(
                                  'ngiamjw@gmail.com',
                                  DateFormat('ddMMyyyy')
                                      .format(DateTime.now())),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error fetching food items'));
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                      heightFactor: 15,
                                      child: Text(
                                          'No food items uploaded today',
                                          style:
                                              TextStyle(color: Colors.white)));
                                }

                                List<Map<String, dynamic>> foodItems =
                                    snapshot.data!;

                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 400,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: foodItems.length,
                                        itemBuilder: (context, index) {
                                          final foodItem = foodItems[index];
                                          String foodName =
                                              foodItem['foodName'];
                                          String imageUrl =
                                              foodItem['imageURL'];
                                          int calories = foodItem['calories'];
                                          int protein = foodItem['protein'];
                                          int carbs = foodItem['carbs'];
                                          int fats = foodItem['fats'];
                                          Timestamp timestamp =
                                              foodItem['timestamp'];
                                          String formattedTime =
                                              DateFormat('h:mm a')
                                                  .format(timestamp.toDate());

                                          return ShowFoodItem(
                                            calories: calories,
                                            carbs: carbs,
                                            fats: fats,
                                            foodName: foodName,
                                            formattedTime: formattedTime,
                                            protein: protein,
                                            imageUrl: imageUrl,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),

                        // ElevatedButton fixed at the bottom
                        Positioned(
                          bottom:
                              30, // Adjust to position above the BottomNavigationBar
                          right: 16,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Your action

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CameraScreen(
                                          daily_calories: calories,
                                          daily_protein: protein,
                                          daily_carbs: carbs,
                                          daily_fats: fats,
                                        )),
                              );
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                              // Full width
                              backgroundColor: Colors.grey.shade400,
                              minimumSize: Size(40, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          }),
    );
  }

  Widget _buildSmallBox(
      String value, String label, double percentage, Widget icon) {
    return Container(
        width: 115,
        height: 145,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left within Column
          children: [
            Padding(
              padding: EdgeInsets.only(left: 7, top: 2, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                        ),
                        Text(
                          label,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 8), // Add some spacing between text and chart if needed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 30,
                          startDegreeOffset: 270,
                          sections: [
                            PieChartSectionData(
                              value: percentage, // Completed portion
                              color: Colors.green,
                              title: "",
                              radius: 5,
                              showTitle: true,
                            ),
                            PieChartSectionData(
                              value: 100 - percentage, // Remaining portion
                              color: Colors.grey,
                              title: "",
                              radius: 5,
                              showTitle: true,
                            ),
                          ],
                        ),
                      ),
                      icon,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
