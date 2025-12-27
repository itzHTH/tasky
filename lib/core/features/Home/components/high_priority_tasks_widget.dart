import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/services/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox_widget.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/features/High%20Prioity%20Tasks/screens/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onChecked,
    required this.loadTasks,
  });

  final List<TaskModel> tasks;
  final Function(bool? value, int index) onChecked;
  final Function loadTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16,
                ),
                child: Text(
                  "High Priority Tasks",
                  style: TextStyle(fontSize: 16, color: Color(0xff15B86C)),
                ),
              ),

              if (tasks.isNotEmpty)
                ...tasks.reversed.take(4).map((element) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomCheckboxWidget(
                        value: element.isDone,
                        onChecked: (value) async {
                          int index = tasks.indexWhere(
                            (task) => task.id == element.id,
                          );
                          onChecked(value, index);
                        },
                      ),
                      SizedBox(width: 8),
                      Text(
                        element.taskName,
                        style: element.isDone
                            ? Theme.of(context).textTheme.titleLarge
                            : Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                      ),
                    ],
                  );
                })
              else
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                  child: Text(
                    "No High Priority Tasks",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              SizedBox(height: 4),
            ],
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HighPriorityScreen();
                  },
                ),
              );
              loadTasks();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThemeController.isDark()
                        ? Color(0xFFD1DAD6)
                        : Color(0xFFD1DAD6),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/images/arrow_right.svg",
                  colorFilter: ColorFilter.mode(
                    ThemeController.isDark()
                        ? Color(0xFFC6C6C6)
                        : Color(0xFF3A4640),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
