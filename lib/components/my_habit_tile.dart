// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  const MyHabitTile({
    super.key,
    required this.text,
    required this.isCompleted,
    this.onChanged,
    this.editHabit,
    this.deleteHabit,
  });

  final String text;
  final bool isCompleted;
  final void Function(bool? value)? onChanged;
  final void Function(BuildContext context)? editHabit;
  final void Function(BuildContext context)? deleteHabit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
              icon: Icons.settings,
            ),
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(8),
              icon: Icons.delete,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                text,
                style: TextStyle(
                  color: isCompleted
                      ? Colors.white
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              leading: Checkbox(
                value: isCompleted,
                activeColor: Colors.green,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
