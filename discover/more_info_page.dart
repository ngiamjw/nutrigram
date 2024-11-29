import 'package:flutter/material.dart';
import 'package:nutrigram/discover/more_info_tile.dart';
import 'package:nutrigram/discover/nutrition_row.dart';
import 'package:nutrigram/theme/app_color.dart';

class MoreInfoPage extends StatefulWidget {
  final Map<String, dynamic> doc;
  const MoreInfoPage({super.key, required this.doc});

  @override
  State<MoreInfoPage> createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.charcoalGray,
        appBar: AppBar(
          backgroundColor: AppColors.charcoalGray,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile picture (circular)
                      Padding(
                        padding: const EdgeInsets.all(8.0), // Add some padding
                        child: CircleAvatar(
                          radius: 30, // Size of the circular image
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150', // Replace with your image URL
                          ),
                        ),
                      ),
                      SizedBox(width: 12), // Spacing between the image and text
                      // Username and subtitle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'chewenyu', // Username
                            style: TextStyle(
                              color: Colors
                                  .white, // White text for dark background
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 4), // Space between username and subtitle
                          Text(
                            'Yesterday', // Subtitle
                            style: TextStyle(
                              color: Colors.grey, // Gray text for subtitle
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  NutritionRow(
                      calories: widget.doc['caloriesConsumed'],
                      carbs: widget.doc['carbsConsumed'],
                      fats: widget.doc['fatsConsumed'],
                      protein: widget.doc['proteinConsumed'])
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.doc['fooditems'].length,
                itemBuilder: (context, index) {
                  return MoreInfoTile(
                      calories: widget.doc['fooditems'][index]['calories'],
                      carbs: widget.doc['fooditems'][index]['calories'],
                      fats: widget.doc['fooditems'][index]['calories'],
                      name: widget.doc['fooditems'][index]['foodName'],
                      protein: widget.doc['fooditems'][index]['calories'],
                      imageURL: widget.doc['fooditems'][index]['imageURL']);
                }),
          ],
        ));
  }
}
