import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/features/Add%20Tasks/screens/add_task_screen.dart';
import 'package:tasky/core/services/shard_pers.dart';
import 'package:tasky/core/features/Home/components/acheived_tasks_widget.dart';
import 'package:tasky/core/features/Home/components/high_priority_tasks_widget.dart';
import 'package:tasky/core/widgets/sliver_tasks_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _fullname;
  late String _movQuote;
  String? _selectedImagePath;
  int _totalTasks = 0;
  int _totalTodoTasks = 0;
  double _achievedTaskPers = 0;

  List<TaskModel> _tasks = [];
  bool isLoading = false;

  void _loadTasks() {
    setState(() {
      isLoading = true;
    });
    final String? tasksJson = SharedPrefsHelper.instance.getStringValue(
      "Tasks",
    );

    if (tasksJson != null) {
      List<dynamic> tasks = jsonDecode(tasksJson) as List<dynamic>;
      setState(() {
        _tasks = tasks
            .map((task) => TaskModel.fromJson(task))
            .cast<TaskModel>()
            .toList();
        _calaculateAcheivedTaskPers();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<bool?> _saveTasks() async {
    final jsonTasks = _tasks.map((task) => task.toMap()).toList();
    return await SharedPrefsHelper.instance.setStringValue(
      "Tasks",
      jsonEncode(jsonTasks),
    );
  }

  void _loadUserDetails() {
    setState(() {
      _fullname =
          SharedPrefsHelper.instance.getStringValue("fullname") ?? "Guset";
      _movQuote =
          SharedPrefsHelper.instance.getStringValue("movQuote") ??
          "One task at a time. One step closer.";
      _selectedImagePath = SharedPrefsHelper.instance.getStringValue(
        "userPhotoPath",
      );
    });
  }

  void _calaculateAcheivedTaskPers() {
    setState(() {
      _totalTasks = _tasks.length;
      _totalTodoTasks = _tasks.where((task) => task.isDone).length;

      // حماية من القسمة على صفر
      if (_totalTasks == 0) {
        _achievedTaskPers = 0;
      } else {
        _achievedTaskPers = _totalTodoTasks / _totalTasks;
      }
    });
  }

  void _deleteTask(int id) async {
    _tasks.removeWhere((e) => e.id == id);
    await _saveTasks();
    _calaculateAcheivedTaskPers();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadTasks();
      _loadUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? res = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
            if (res != null && res) {
              _loadTasks();
            }
          },
          backgroundColor: Color(0xff15B86C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          label: Text(
            "Add New Task",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          icon: Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: _selectedImagePath == null
                              ? AssetImage("assets/images/pe.png")
                              : FileImage(File(_selectedImagePath!)),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Evening , $_fullname",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              _movQuote,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Yuhuu ,Your work Is",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                "almost done !",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              SizedBox(width: 8),
                              SvgPicture.asset(
                                "assets/images/waving-hanhsvg.svg",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    AcheivedTasksWidget(
                      totalTodoTasks: _totalTodoTasks,
                      totalTasks: _totalTasks,
                      achievedTaskPers: _achievedTaskPers,
                    ),
                    SizedBox(height: 8),
                    HighPriorityTasksWidget(
                      loadTasks: () => _loadTasks(),
                      tasks: _tasks.where((e) => e.isHighPriority).toList(),
                      onChecked: (value, index) async {
                        setState(() {
                          _tasks[index].isDone = value ?? false;
                          _calaculateAcheivedTaskPers();
                        });
                        await _saveTasks();
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),

              isLoading
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Color(0xff15B86C),
                        ),
                      ),
                    )
                  : SliverTasksListWidget(
                      tasks: _tasks,
                      onChecked: (value, index) async {
                        setState(() {
                          _tasks[index!].isDone = value ?? false;
                          _calaculateAcheivedTaskPers();
                        });
                        await _saveTasks();
                      },
                      onDeleted: (int id) {
                        _deleteTask(id);
                      },
                      onTaskEdited: () {
                        _loadTasks();
                        setState(() {});
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
