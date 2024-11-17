import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram/camera/camera.dart';
import 'package:nutrigram/components/image_display_input.dart';
import 'package:nutrigram/database/firebase_nutrition.dart';
import 'package:nutrigram/pages/home_page.dart';
import 'dart:io';

import 'package:nutrigram/theme/app_color.dart';

class ImageDetailsPage extends StatelessWidget {
  final File image;
  final Map<String, dynamic> response;
  final int daily_calories;
  final int daily_protein;
  final int daily_carbs;
  final int daily_fats;

  ImageDetailsPage(
      {required this.image,
      required this.response,
      required this.daily_calories,
      required this.daily_carbs,
      required this.daily_fats,
      required this.daily_protein});
  FirestoreServiceNutrition firestoreservice = FirestoreServiceNutrition();
  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller =
        TextEditingController(text: response['name']);
    TextEditingController caloriecontroller =
        TextEditingController(text: response['calories'].toString());
    TextEditingController proteincontroller =
        TextEditingController(text: response['protein'].toString());
    TextEditingController carbcontroller =
        TextEditingController(text: response['carbs'].toString());
    TextEditingController fatcontroller =
        TextEditingController(text: response['fats'].toString());
    return Scaffold(
      backgroundColor: AppColors.charcoalGray,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.charcoalGray,
        title: Text('Image Details', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image at the top
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                height: 250,
                width: 250,
                color: Colors.grey[300], // In case the image doesn't load
                child: image != null
                    ? Image.file(image, fit: BoxFit.cover)
                    : SizedBox.shrink(),
              ),
            ),
            SizedBox(height: 50),

            // Dish Name
            Padding(
              padding: const EdgeInsets.only(left: 65),
              child: Row(
                children: [
                  Text("Dish:",
                      style: TextStyle(
                          fontSize: 20, color: AppColors.primaryText)),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: namecontroller,
                      style:
                          TextStyle(color: AppColors.primaryText, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: 'Enter dish name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),

            // Calories and Protein Row
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  ImageDisplayInput(
                    title: "Calories",
                    mycontroller: caloriecontroller,
                  ),
                  SizedBox(width: 20),
                  ImageDisplayInput(
                    title: "Protein",
                    mycontroller: proteincontroller,
                  )
                ],
              ),
            ),
            SizedBox(height: 40),

            // Carbs and Fats Row
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  ImageDisplayInput(
                    title: "Carbs",
                    mycontroller: carbcontroller,
                  ),
                  SizedBox(width: 43),
                  ImageDisplayInput(
                    title: "Fats",
                    mycontroller: fatcontroller,
                  )
                ],
              ),
            ),

            Spacer(),

            // Bottom Buttons (Retake & Upload)
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your "Retake" functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraScreen(
                                    daily_calories: daily_calories,
                                    daily_carbs: daily_carbs,
                                    daily_fats: daily_fats,
                                    daily_protein: daily_protein,
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Retake",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Add your "Upload" functionality here
                        await firestoreservice.saveFoodItem(
                            'ngiamjw@gmail.com',
                            DateFormat('ddMMyyyy').format(DateTime.now()),
                            namecontroller.text,
                            int.parse(caloriecontroller.text),
                            int.parse(proteincontroller.text),
                            int.parse(carbcontroller.text),
                            int.parse(fatcontroller.text),
                            image,
                            daily_calories,
                            daily_protein,
                            daily_carbs,
                            daily_fats);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Upload",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
