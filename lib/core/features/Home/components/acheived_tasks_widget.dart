import 'package:flutter/material.dart';
import 'package:tasky/core/services/theme_controller.dart';

class AcheivedTasksWidget extends StatelessWidget {
  const AcheivedTasksWidget({
    super.key,
    required this.totalTodoTasks,
    required this.totalTasks,
    required this.achievedTaskPers,
  });
  final int totalTodoTasks;
  final int totalTasks;
  final double achievedTaskPers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      height: 72,
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "$totalTodoTasks Out of $totalTasks Done",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: CircularProgressIndicator(
                      value: achievedTaskPers,
                      backgroundColor: ThemeController.isDark()
                          ? Color(0xFF6D6D6D)
                          : Color(0XFF9E9E9E),
                      valueColor: AlwaysStoppedAnimation(Color(0xff15B86C)),
                      strokeWidth: 4,
                    ),
                  ),
                  Text(
                    "${(achievedTaskPers * 100).toInt()}%",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
