import 'package:flutter/material.dart';
import 'package:nutrigram/theme/app_color.dart';
import 'package:nutrigram/workout_pages/workout_detail.dart';
import 'package:nutrigram/workout_pages/workout_item.dart';

class WorkoutPageTile extends StatelessWidget {
  Map<String, dynamic> workoutData;
  WorkoutPageTile({super.key, required this.workoutData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Box
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 290,
                    child: Text("Afternoon Workout",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText)),
                  ),
                  Text(
                    "6.43am",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WorkoutDetail(
                      title: 'Time', value: '${workoutData['duration']}'),
                  WorkoutDetail(
                      title: 'Volume', value: '${workoutData['volume']}'),
                  WorkoutDetail(
                      title: 'Sets', value: '${workoutData['totalSets']}'),
                  WorkoutDetail(
                      title: 'Records',
                      value: '${workoutData['records']}',
                      icon: Icons.emoji_events),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(color: Colors.grey.shade800),
              SizedBox(
                height: 4,
              ),
              if (workoutData['exercises'].length == 1)
                Column(
                  children: List.generate(1, (index) {
                    return WorkoutItem(
                        image: 'test',
                        title:
                            '${workoutData['exercises'][index]['sets'].length} sets of ${workoutData['exercises'][index]['exerciseName']}s');
                  }),
                ),
              if (workoutData['exercises'].length == 2)
                Column(
                  children: List.generate(2, (index) {
                    return WorkoutItem(
                        image: 'test',
                        title:
                            '${workoutData['exercises'][index]['sets'].length} sets of ${workoutData['exercises'][index]['exerciseName']}s');
                  }),
                ),
              if (workoutData['exercises'].length >= 3)
                Column(
                  children: [
                    Column(
                      children: List.generate(3, (index) {
                        return WorkoutItem(
                            image: 'test',
                            title:
                                '${workoutData['exercises'][index]['sets'].length} sets of ${workoutData['exercises'][index]['exerciseName']}s');
                      }),
                    ),
                    Center(
                      child: Text(
                        'See ${workoutData['exercises'].length - 3} more exercises',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              SizedBox(
                height: 4,
              ),
              Divider(color: Colors.grey.shade800),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 30,
                    color: Colors.grey,
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Colors.blue,
                    indent: 1,
                    endIndent: 1,
                  ),
                  Icon(
                    Icons.share,
                    size: 30,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
