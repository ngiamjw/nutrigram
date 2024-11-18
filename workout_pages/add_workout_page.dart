import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram/database/firebase_workout.dart';
import 'package:nutrigram/pages/home_page.dart';
import 'package:nutrigram/pages/workout_page.dart';
import 'package:nutrigram/theme/app_color.dart';
import 'package:nutrigram/workout_pages/workout_container.dart';
import 'package:nutrigram/workout_pages/workout_data.dart';
import 'package:nutrigram/workout_pages/workout_detail.dart';
// Import your WorkoutData class
import 'dart:async';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  late Timer _timer;
  Duration _duration = Duration(seconds: 0);
  WorkoutData _workout = WorkoutData();
  firestoreServiceWorkout firestoreservice = firestoreServiceWorkout();
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  void _addSet(int exerciseIndex) {
    setState(() {
      _workout.exercises[exerciseIndex].addSet();
      _workout.updateTotalSets(); // Update the total sets after adding a set
    });
  }

  void _addExercise() {
    setState(() {
      _workout.addExercise(ExerciseData(
          exerciseName: 'Pull Up',
          sets: [WorkoutSet(setNumber: 1), WorkoutSet(setNumber: 2)]));
    });
  }

  void _removeSet(int exerciseIndex, int setIndex) {
    setState(() {
      _workout.exercises[exerciseIndex].removeSet(setIndex);
      _workout.updateTotalSets(); // Update the total set count after removal
      print('Set $setIndex removed from exercise $exerciseIndex');
      print(
          '${_workout.exercises[exerciseIndex].sets.length}'); // Debug statement
    });
  }

  void _discardWorkout() {
    setState(() {
      _workout.clearWorkout();
      _duration = Duration(seconds: 0);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formattedDuration() {
    final minutes =
        _duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        _duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes min $seconds s";
  }

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
          GestureDetector(
            onTap: () {
              // Finish action here
              firestoreservice.uploadWorkoutData('ngiamjw@gmail.com', _workout,
                  DateFormat('ddMMyyyy').format(DateTime.now()));

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(currentpage: 1)),
              );
            },
            child: Padding(
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
        child: ListView(
          children: [
            // First Box for Duration, Volume, Sets, Records
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WorkoutDetail(
                          title: 'Duration', value: _formattedDuration()),
                      WorkoutDetail(
                          title: 'Volume',
                          value: '0 kg'), // Volume will be left blank for now
                      WorkoutDetail(
                          title: 'Sets', value: '${_workout.totalSets}'),
                      WorkoutDetail(
                          title: 'Records',
                          value: '1',
                          icon: Icons.emoji_events), // Records left blank
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // List of workouts
            for (int i = 0; i < _workout.exercises.length; i++) ...[
              buildWorkoutContainer(
                context: context,
                workoutData: _workout.exercises[i],
                index: i,
                onAddSet: _addSet,
                removeSet: _removeSet,
              ),
              SizedBox(height: 16),
            ],

            // Add Exercise Button
            ElevatedButton.icon(
              onPressed: _addExercise,
              icon: Icon(Icons.add, color: Colors.white),
              label:
                  Text('Add Exercise', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 16),

            // Settings and Discard Workout Buttons
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
                    onPressed: _discardWorkout,
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
