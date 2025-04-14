import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          // return TaskCard(
          //   taskStatus: TaskStatus.completed,
          //   taskModel: widget.taskModel,
          // );
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: 6,
      ),
    );
  }
}
