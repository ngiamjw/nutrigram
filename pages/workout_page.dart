import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram/database/firebase_workout.dart';
import 'package:nutrigram/theme/app_color.dart';
import 'package:nutrigram/workout_pages/add_workout_page.dart';
import 'package:nutrigram/workout_pages/workout_detail.dart';
import 'package:nutrigram/workout_pages/workout_item.dart';
import 'package:nutrigram/workout_pages/workout_page_tile.dart';

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    firestoreServiceWorkout firestoreservice = firestoreServiceWorkout();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
              future: firestoreservice.getWorkoutData('ngiamjw@gmail.com',
                  DateFormat('ddMMyyyy').format(DateTime.now())),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading indicator
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}')); // Error message
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text('No workout data found.')); // No data message
                }

                List<Map<String, dynamic>> workoutDataList = snapshot.data!;

                return ListView.builder(
                    itemCount: workoutDataList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> workoutData = workoutDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: WorkoutPageTile(
                          workoutData: workoutData,
                        ),
                      );
                    });
              }),
          Positioned(
            bottom: 30,
            right: 16,
            child: ElevatedButton(
              onPressed: () async {
                // Your action

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWorkoutPage()),
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
      ),
    );
  }

  Widget _buildWorkoutDetail(String value, String label) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
