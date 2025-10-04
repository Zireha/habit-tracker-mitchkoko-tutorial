import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTiles extends StatelessWidget {
  final String habitName;
  final bool isCompleted;
  final Function(bool?) onChanged;
  final Function(BuildContext)? settingTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTiles({
    super.key,
    required this.habitName,
    required this.isCompleted,
    required this.onChanged,
    required this.settingTapped,
    required this.deleteTapped
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //Setting
            SlidableAction(
              onPressed: settingTapped,
              backgroundColor: Colors.deepPurple.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),

            //Delete
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.deepPurple[100],
            borderRadius: BorderRadius.circular(8),
          ),

          child: Row(
            children: [
              Checkbox(value: isCompleted, onChanged: onChanged),
              Text(habitName),
            ],
          ),
        ),
      ),
    );
  }
}
