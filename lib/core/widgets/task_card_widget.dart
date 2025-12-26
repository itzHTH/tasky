import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/enums/popup_actions_enum.dart';
import 'package:tasky/core/services/shard_pers.dart';
import 'package:tasky/core/services/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox_widget.dart';
import 'package:tasky/core/widgets/custom_text_form_filed_widget.dart';
import 'package:tasky/models/task_model.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.task,
    required this.onChecked,
    required this.onDeleted,
    required this.onTaskEdited,
  });

  final TaskModel task;

  final Function(bool? value) onChecked;
  final Function(int id) onDeleted;
  final Function() onTaskEdited;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 58,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ThemeController.isDark()
                ? Colors.transparent
                : Color(0xFFD1DAD6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomCheckboxWidget(value: task.isDone, onChecked: onChecked),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskName,
                    style: task.isDone
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleMedium,

                    maxLines: 1,
                  ),
                  task.taskDescription!.isNotEmpty
                      ? Text(
                          task.taskDescription!,
                          style: task.isDone
                              ? Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                )
                              : Theme.of(context).textTheme.labelSmall,
                          maxLines: 1,
                        )
                      : SizedBox(),
                ],
              ),
            ),

            PopupMenuButton<PopupActionsEnum>(
              onSelected: (value) {
                switch (value) {
                  case PopupActionsEnum.markAsDone:
                    onChecked(!task.isDone);

                  case PopupActionsEnum.edit:
                    _showEditTaskBottomSheet(context, task);

                  case PopupActionsEnum.delete:
                    _showAlertDialog(context);
                }
              },
              itemBuilder: (context) => PopupActionsEnum.values
                  .map(
                    (e) => PopupMenuItem<PopupActionsEnum>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showEditTaskBottomSheet(
    BuildContext context,
    TaskModel model,
  ) {
    List<TaskModel> tasks = [];

    GlobalKey<FormState> key = .new();
    final TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController taskDescController = TextEditingController(
      text: model.taskDescription,
    );
    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 14,
                  ),
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        CustomTextFormFiledWidget(
                          title: "Task Name",
                          hintText: "e.g. Flutter Course",
                          formValidator: (value) {
                            if (value?.trim().isEmpty ?? false) {
                              return "Please Enter Task Name !.";
                            }
                            return null;
                          },
                          controllor: taskNameController,
                        ),

                        SizedBox(height: 20),
                        CustomTextFormFiledWidget(
                          hintText: "e.g. Complete 3 Video From Flutter Course",
                          maxLine: 6,
                          title: "Task Name",
                          controllor: taskDescController,
                        ),

                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Priority",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),

                            Switch(
                              value: isHighPriority,
                              onChanged: (value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        ElevatedButton.icon(
                          onPressed: () async {
                            if (key.currentState?.validate() ?? false) {
                              // Load Tasks
                              final String? tasksJson = SharedPrefsHelper
                                  .instance
                                  .getStringValue("Tasks");
                              if (tasksJson != null) {
                                List<dynamic> tasks2 =
                                    jsonDecode(tasksJson) as List<dynamic>;
                                setState(() {
                                  tasks = tasks2
                                      .map((task) => TaskModel.fromJson(task))
                                      .cast<TaskModel>()
                                      .toList();
                                });
                                //

                                // new Model
                                TaskModel newModel = TaskModel(
                                  id: model.id,
                                  taskName: taskNameController.text,
                                  taskDescription: taskDescController.text,
                                  isHighPriority: isHighPriority,
                                  isDone: model.isDone,
                                );
                                //

                                // get Current task Index to save the new model in it
                                int currentTaskIndex = tasks.indexWhere(
                                  (e) => e.id == newModel.id,
                                );
                                //

                                // save the new model in the current task index
                                tasks[currentTaskIndex] = newModel;
                                //

                                // save The edited Task
                                final jsonTasks = tasks
                                    .map((task) => task.toMap())
                                    .toList();
                                await SharedPrefsHelper.instance.setStringValue(
                                  "Tasks",
                                  jsonEncode(jsonTasks),
                                );
                                //

                                onTaskEdited();

                                Navigator.of(context).pop();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              40,
                            ),
                          ),
                          icon: Icon(Icons.edit),
                          label: Text(
                            "Edit Task",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<dynamic> _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Delete Task",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          content: Text(
            "Are You Sure To Delete Task?",
            style: Theme.of(context).textTheme.labelMedium,
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),

            TextButton(
              onPressed: () {
                onDeleted(task.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
