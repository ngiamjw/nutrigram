import 'package:flutter/material.dart';

class WorkoutDetail extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const WorkoutDetail({
    required this.title,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.amber, size: 18),
            if (icon != null) SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
