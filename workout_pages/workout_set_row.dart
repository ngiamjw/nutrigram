import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nutrigram/workout_pages/workout_data.dart';

Widget buildSetRow({
  required BuildContext context,
  required WorkoutSet workoutSet,
  required int index,
  required int exercisedataindex,
  required Function(int, int)
      removeSet, // To uniquely identify the Dismissible widget
}) {
  return Slidable(
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            removeSet(exercisedataindex, index);
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '${workoutSet.setNumber}',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Expanded(
          child: Text(
            'x ${workoutSet.reps}',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (text) {
              workoutSet.reps = int.tryParse(text) ?? 0;
            },
            decoration: InputDecoration(
              hintText: '${workoutSet.reps}',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
          icon: Icon(
            workoutSet.completed
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: workoutSet.completed ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            workoutSet.completed = !workoutSet.completed;
          },
        ),
      ],
    ),
  );
}
