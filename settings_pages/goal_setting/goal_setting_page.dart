import 'package:flutter/material.dart';
import 'package:nutrigram/components/setting_tile.dart';
import 'package:nutrigram/settings_pages/goal_setting/goal_class.dart';

class GoalSettingPage extends StatefulWidget {
  Map<String, dynamic> user_info;
  GoalSettingPage({super.key, required this.user_info});

  @override
  State<GoalSettingPage> createState() => _GoalSettingPageState();
}

class _GoalSettingPageState extends State<GoalSettingPage> {
  @override
  Widget build(BuildContext context) {
    GoalClass goalClass = GoalClass();
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Goals',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView(
          children: [
            SettingsTile(
              title: "Starting Weight",
              value: "${widget.user_info['weight']}",
              onTap: () {
                goalClass.showStartingWeightPicker(
                    context, widget.user_info, this);
              },
            ),
            SettingsTile(
              title: "Current Weight",
              value: "${widget.user_info['current_weight']}",
              onTap: () {
                goalClass.showCurrentWeightPicker(
                    context, widget.user_info, this);
              },
            ),
            SettingsTile(
              title: "Goal Weight",
              value: "${widget.user_info['goal_weight']}",
              onTap: () {
                goalClass.showGoalWeightPicker(context, widget.user_info, this);
              },
            ),
            SettingsTile(
              title: "Weekly Goal",
              value: "${widget.user_info['weekly_goal']}",
              onTap: () {
                goalClass.WeeklyGoalPicker(context, widget.user_info, this);
              },
            ),
            SettingsTile(
              title: "Activity Level",
              value: "${widget.user_info['workoutsPerWeek']}",
              onTap: () {
                goalClass.WorkoutPicker(context, widget.user_info, this);
              },
            ),
          ],
        ),
      ),
    );
  }
}
