import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/theme/app_color.dart';
import 'package:nutrigram/workout_pages/add_workout_page.dart';
import 'package:nutrigram/workout_pages/workout_detail.dart';
import 'package:nutrigram/workout_pages/workout_item.dart';

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
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
                        WorkoutDetail(title: 'Time', value: '1h 35min'),
                        WorkoutDetail(title: 'Volume', value: '5,745 kg'),
                        WorkoutDetail(title: 'Sets', value: '10'),
                        WorkoutDetail(
                            title: 'Records',
                            value: '1',
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
                    WorkoutItem(
                      image: 'assets/bench_press.png',
                      title: '2 sets Bench Press (Barbell)',
                    ),
                    WorkoutItem(
                      image: 'assets/incline_press.png',
                      title: '2 sets Incline Bench Press (Dumbbell)',
                    ),
                    WorkoutItem(
                      image: 'assets/lat_pulldown.png',
                      title: '2 sets Lat Pulldown (Machine)',
                    ),
                    Center(
                      child: Text(
                        'See 6 more exercises',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
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
          ),
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
