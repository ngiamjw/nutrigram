import 'package:flutter/material.dart';
import 'package:nutrigram/theme/app_color.dart';
import 'package:nutrigram/workout_pages/workout_detail.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalGray,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                "Finish",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          )
        ],
        title: Text(
          "Log Workout",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2C2C2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WorkoutDetail(title: 'Duration', value: '1h 35min'),
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
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/pull_up.png'), // Replace with the actual image
                            radius: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Pull Up',
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
                      Text(
                        'Add notes here...',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.timer, color: Colors.blue, size: 18),
                          SizedBox(width: 8),
                          Text('Rest Timer: OFF',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text('SET',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                          Expanded(
                            child: Text('PREVIOUS',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                          Expanded(
                            child: Text('REPS',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                          SizedBox(width: 32), // Space for the check mark icon
                        ],
                      ),
                      Divider(color: Colors.grey.shade800),
                      // Example Set 1
                      Row(
                        children: [
                          Expanded(
                            child: Text('1',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                          Expanded(
                            child: Text('x 12',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                          Expanded(
                            child: Text('12',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                          Icon(Icons.check_box, color: Colors.grey, size: 24),
                        ],
                      ),
                      Divider(color: Colors.grey.shade800),
                      // Example Set 2
                      Row(
                        children: [
                          Expanded(
                            child: Text('2',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                          Expanded(
                            child: Text('x 8',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                          Expanded(
                            child: Text('8',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                          Icon(Icons.check_box, color: Colors.grey, size: 24),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text('Add Set',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: Colors.white),
              label:
                  Text('Add Exercise', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child:
                        Text('Settings', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Discard Workout',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
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
