import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/complete_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    _getAllCompleteTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompleteTaskController>(
        builder:
            (controller) => Visibility(
              visible: controller.getCompleteTasksInProgress == false,
              replacement: CenteredCircularProgressIndicator(),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return TaskCard(
                    refreshList: _getAllCompleteTaskList,
                    taskStatus: TaskStatus.completed,
                    taskModel: controller.completedTaskList[index],
                    onTaskDeleted: (task) async {
                      controller.completedTaskList.removeWhere(
                        (t) => t.id == task.id,
                      );
                      await _getAllCompleteTaskList();
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: controller.completedTaskList.length,
              ),
            ),
      ),
    );
  }

  Future<void> _getAllCompleteTaskList() async {
    final bool isSucess =
        await Get.find<CompleteTaskController>().getAllCompleteTaskList();
    if (!isSucess) {
      showSnackBarMessage(
        context,
        Get.find<CompleteTaskController>().errorMessage!,
        true,
      );
    }
  }
}
