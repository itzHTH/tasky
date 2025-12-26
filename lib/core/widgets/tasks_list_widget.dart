import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/widgets/task_card_widget.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({
    super.key,
    required this.tasks,
    required this.onChecked,
    this.emptyDataText,
    required this.onDeleted,
    required this.onTaskEdited,
  });

  final List<TaskModel> tasks;
  final Function(bool? value, int? index) onChecked;
  final String? emptyDataText;
  final Function(int id) onDeleted;
  final Function() onTaskEdited;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyDataText ?? "No Data",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 45),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskCardWidget(
                task: tasks[index],

                onChecked: (value) {
                  onChecked(value, index);
                },
                onDeleted: (int id) {
                  onDeleted(id);
                },
                onTaskEdited: () {
                  onTaskEdited();
                },
              );
            },
          );
  }
}
