import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/database/firebase_nutrition.dart';
import 'package:nutrigram/discover/discover_tile.dart';
import 'package:nutrigram/theme/app_color.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  FirestoreServiceNutrition firestoreservice = FirestoreServiceNutrition();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: firestoreservice.getDocumentsWithFoodItems('ngiamjw@gmail.com'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No valid documents found."),
            );
          } else {
            // Display the filtered documents
            List<Map<String, dynamic>> documents = snapshot.data!;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                final foodItems = doc['fooditems'] as List;

                return DiscoverTile(
                  doc: doc,
                );
              },
            );
          }
        });
  }
}
