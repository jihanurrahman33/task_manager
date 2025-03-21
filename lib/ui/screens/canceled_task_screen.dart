import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return TaskCard(taskStatus: TaskStatus.canceled);
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: 6,
      ),
    );
  }
}
