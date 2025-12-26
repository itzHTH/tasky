import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/services/shard_pers.dart';
import 'package:tasky/core/widgets/tasks_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> _highPriorityTasks = [];
  List<TaskModel> _allTasks = [];

  bool isLoading = false;

  void _loadHighPriorityTasks() async {
    setState(() {
      isLoading = true;
    });
    final String? tasksJson = SharedPrefsHelper.instance.getStringValue(
      "Tasks",
    );

    if (tasksJson != null) {
      List<dynamic> tasks = jsonDecode(tasksJson) as List<dynamic>;
      setState(() {
        _highPriorityTasks = tasks
            .map((task) => TaskModel.fromJson(task))
            .cast<TaskModel>()
            .where((task) => task.isHighPriority)
            .toList();

        _highPriorityTasks = _highPriorityTasks.reversed.toList();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void _loadAllTasks() async {
    final String? tasksJson = SharedPrefsHelper.instance.getStringValue(
      "Tasks",
    );

    if (tasksJson != null) {
      List<dynamic> tasks = jsonDecode(tasksJson) as List<dynamic>;
      setState(() {
        _allTasks = tasks
            .map((task) => TaskModel.fromJson(task))
            .cast<TaskModel>()
            .toList();
      });
    }
  }

  Future<bool?> _saveTasks() async {
    final jsonTasks = _allTasks.map((task) => task.toMap()).toList();
    return await SharedPrefsHelper.instance.setStringValue(
      "Tasks",
      jsonEncode(jsonTasks),
    );
  }

  void _deleteTask(int id) async {
    _loadAllTasks();
    _allTasks.removeWhere((e) => e.id == id);
    await _saveTasks();
    _loadHighPriorityTasks();
  }

  @override
  void initState() {
    _loadHighPriorityTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Color(0xff15B86C),
                ),
              )
            : TasksListWidget(
                tasks: _highPriorityTasks,
                onChecked: (value, index) async {
                  setState(() {
                    _highPriorityTasks[index!].isDone = value ?? false;
                  });
                  _loadAllTasks();

                  final int newIndex = _allTasks.indexWhere(
                    (task) => task.id == _highPriorityTasks[index!].id,
                  );
                  _allTasks[newIndex] = _highPriorityTasks[index!];
                  await _saveTasks();
                  _loadHighPriorityTasks();
                },
                emptyDataText: "No High Priority Tasks :)",
                onDeleted: (int id) {
                  _deleteTask(id);
                },
                onTaskEdited: () {
                  _loadHighPriorityTasks();
                },
              ),
      ),
    );
  }
}
