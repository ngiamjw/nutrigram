import 'package:flutter/material.dart';
import 'package:nutrigram/discover/nutrition_row.dart';

class MoreInfoTile extends StatelessWidget {
  final String name;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final String imageURL;
  const MoreInfoTile(
      {super.key,
      required this.calories,
      required this.carbs,
      required this.fats,
      required this.name,
      required this.protein,
      required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$name',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'notes',
              style: TextStyle(color: Colors.white),
            ),
            NutritionRow(
                calories: calories, carbs: carbs, fats: fats, protein: protein),
            SizedBox(
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Same as the decoration
                child: Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
