import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/services/shard_pers.dart';
import 'package:tasky/core/widgets/tasks_list_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> _completedTasks = [];
  List<TaskModel> _allTasks = [];

  bool isLoading = false;

  void _loadCompletedTasks() async {
    setState(() {
      isLoading = true;
    });
    final String? tasksJson = SharedPrefsHelper.instance.getStringValue(
      "Tasks",
    );

    if (tasksJson != null) {
      List<dynamic> tasks = jsonDecode(tasksJson) as List<dynamic>;
      setState(() {
        _completedTasks = tasks
            .map((task) => TaskModel.fromJson(task))
            .cast<TaskModel>()
            .where((task) => task.isDone)
            .toList();
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
    _loadCompletedTasks();
  }

  @override
  void initState() {
    _loadCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height: 16),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Color(0xff15B86C),
                    ),
                  )
                : TasksListWidget(
                    tasks: _completedTasks,
                    onChecked: (value, index) async {
                      setState(() {
                        _completedTasks[index!].isDone = value ?? false;
                      });
                      _loadAllTasks();

                      final int newIndex = _allTasks.indexWhere(
                        (task) => task.id == _completedTasks[index!].id,
                      );
                      _allTasks[newIndex] = _completedTasks[index!];
                      await _saveTasks();
                      _loadCompletedTasks();
                    },
                    emptyDataText: "No Tasks Completed :)",
                    onDeleted: (int id) {
                      _deleteTask(id);
                    },
                    onTaskEdited: () {
                      _loadCompletedTasks();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
