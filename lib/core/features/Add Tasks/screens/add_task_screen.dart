import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_text_form_filed_widget.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/services/shard_pers.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  bool isHighPriority = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Form(
                      key: _key,
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
                            hintText:
                                "e.g. Complete 3 Video From Flutter Course",
                            maxLine: 6,
                            title: "Task Name",
                            controllor: taskDescController,
                          ),

                          SizedBox(height: 24),
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

                          Spacer(),

                          ElevatedButton.icon(
                            onPressed: () async {
                              List<dynamic> tasks = [];
                              String? tasksJson = SharedPrefsHelper.instance
                                  .getStringValue("Tasks");
                              if (tasksJson != null) {
                                tasks = jsonDecode(tasksJson) as List<dynamic>;
                              }

                              if (_key.currentState?.validate() ?? false) {
                                TaskModel task = TaskModel(
                                  id: tasks.length + 1,
                                  taskName: taskNameController.text,
                                  taskDescription: taskDescController.text,
                                  isHighPriority: isHighPriority,
                                );

                                tasks.add(task.toMap());

                                tasksJson = jsonEncode(tasks);
                                await SharedPrefsHelper.instance.setStringValue(
                                  "Tasks",
                                  tasksJson,
                                );
                                taskNameController.clear();
                                taskDescController.clear();
                                setState(() {
                                  isHighPriority = true;
                                });
                                Navigator.of(context).pop(true);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width,
                                40,
                              ),
                              foregroundColor: Colors.white,
                            ),
                            icon: Icon(Icons.add),
                            label: Text(
                              "Add Task",
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
