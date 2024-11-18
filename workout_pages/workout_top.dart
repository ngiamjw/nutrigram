import 'package:flutter/material.dart';
import 'package:nutrigram/workout_pages/workout_detail.dart';

class WorkoutTop extends StatelessWidget {
  String duration;
  String sets;
  WorkoutTop({super.key, required this.duration, required this.sets});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              WorkoutDetail(title: 'Duration', value: duration),
              WorkoutDetail(
                  title: 'Volume',
                  value: '0 kg'), // Volume will be left blank for now
              WorkoutDetail(title: 'Sets', value: sets),
              WorkoutDetail(
                  title: 'Records',
                  value: '1',
                  icon: Icons.emoji_events), // Records left blank
            ],
          ),
        ],
      ),
    );
  }
}
