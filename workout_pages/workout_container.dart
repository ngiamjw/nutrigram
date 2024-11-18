import 'package:flutter/material.dart';
import 'package:nutrigram/workout_pages/workout_data.dart';
import 'workout_set_row.dart'; // Import workout_set_row for set row logic

Widget buildWorkoutContainer({
  required BuildContext context,
  required ExerciseData workoutData,
  required int index,
  required Function(int) onAddSet,
  required Function(int, int) removeSet,
}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF2C2C2E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Workout header
        Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage('assets/pull_up.png'), // Replace with actual image
              radius: 24,
            ),
            SizedBox(width: 10),
            Text(
              workoutData.exerciseName,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.more_vert, color: Colors.white, size: 30),
          ],
        ),
        SizedBox(height: 10),

        // Notes section
        TextField(
          onChanged: (text) {
            workoutData.notes = text;
          },
          decoration: InputDecoration(
            hintText: 'Add notes here...',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 16),

        // Rest timer row
        Row(
          children: [
            Icon(Icons.timer, color: Colors.blue, size: 18),
            SizedBox(width: 8),
            Text('Rest Timer: OFF',
                style: TextStyle(color: Colors.blue, fontSize: 16)),
          ],
        ),
        SizedBox(height: 16),

        // Set details header
        Row(
          children: [
            Expanded(
                child: Text('SET',
                    style: TextStyle(color: Colors.grey, fontSize: 16))),
            Expanded(
                child: Text('PREVIOUS',
                    style: TextStyle(color: Colors.grey, fontSize: 16))),
            Expanded(
                child: Text('REPS',
                    style: TextStyle(color: Colors.grey, fontSize: 16))),
            SizedBox(width: 32), // Space for the check mark icon
          ],
        ),
        Divider(color: Colors.grey.shade800),

        // Sets
        for (int j = 0; j < workoutData.sets.length; j++) ...[
          buildSetRow(
              context: context,
              workoutSet: workoutData.sets[j],
              index: j,
              exercisedataindex: index,
              removeSet: removeSet),
          Divider(color: Colors.grey.shade800),
        ],

        // Add Set Button
        ElevatedButton.icon(
          onPressed: () => onAddSet(index),
          icon: Icon(Icons.add, color: Colors.white),
          label: Text('Add Set', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ],
    ),
  );
}
