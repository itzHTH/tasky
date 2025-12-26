import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/services/shard_pers.dart';
import 'package:tasky/core/widgets/tasks_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> _todoTasks = [];
  List<TaskModel> _allTasks = [];

  bool isLoading = false;

  void _loadTodoTasks() async {
    setState(() {
      isLoading = true;
    });
    final String? tasksJson = SharedPrefsHelper.instance.getStringValue(
      "Tasks",
    );

    if (tasksJson != null) {
      List<dynamic> tasks = jsonDecode(tasksJson) as List<dynamic>;
      setState(() {
        _todoTasks = tasks
            .map((task) => TaskModel.fromJson(task))
            .cast<TaskModel>()
            .where((task) => task.isDone == false)
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
    _loadTodoTasks();
  }

  @override
  void initState() {
    _loadTodoTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("To Do Tasks", style: Theme.of(context).textTheme.displaySmall),
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
                    tasks: _todoTasks,
                    onChecked: (value, index) async {
                      setState(() {
                        _todoTasks[index!].isDone = value ?? false;
                      });
                      _loadAllTasks();

                      final int newIndex = _allTasks.indexWhere(
                        (task) => task.id == _todoTasks[index!].id,
                      );
                      _allTasks[newIndex] = _todoTasks[index!];
                      await _saveTasks();
                      _loadTodoTasks();
                    },
                    emptyDataText: "No Task To Do :)",
                    onDeleted: (int id) {
                      _deleteTask(id);
                    },
                    onTaskEdited: () {
                      _loadTodoTasks();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
