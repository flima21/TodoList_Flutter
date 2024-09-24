import 'package:flutter/material.dart';
import 'package:to_do_list/models/Task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoListItem extends StatelessWidget {
  const ToDoListItem({super.key, required this.task, required this.onDelete});

  final Task task;
  final Function(Task) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        key: const ValueKey(1),
        // startActionPane: ActionPane(motion: ScrollMotion(), children: [
        //   SlidableAction(
        //     onPressed: doNothing,
        //     backgroundColor: Colors.blue,
        //     foregroundColor: Colors.white,
        //     icon: Icons.edit,
        //     borderRadius: BorderRadius.circular(16),
        //     label: "Edit",
        //   ),
        // ]),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) => {
                onDelete(task),
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(16),
              label: "Delete",
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                task.dateTime.toIso8601String(),
                style: TextStyle(fontSize: 12),
              ),
              Text(
                task.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {
  print(context);
}
