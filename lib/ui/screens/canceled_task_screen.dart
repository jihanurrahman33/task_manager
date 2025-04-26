import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/cancel_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  void initState() {
    _getAllCanceledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelTaskController>(
        builder:
            (controller) => Visibility(
              visible: controller.getCancelTasksInProgress == false,
              replacement: CenteredCircularProgressIndicator(),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return TaskCard(
                    refreshList: _getAllCanceledTaskList,
                    taskStatus: TaskStatus.canceled,
                    taskModel: controller.cancelTaskList[index],
                    onTaskDeleted: (task) async {
                      controller.cancelTaskList.removeWhere(
                        (t) => t.id == task.id,
                      );
                      await _getAllCanceledTaskList();
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: controller.cancelTaskList.length,
              ),
            ),
      ),
    );
  }

  Future<void> _getAllCanceledTaskList() async {
    final bool isSucess =
        await Get.find<CancelTaskController>().getAllCancelTaskList();
    if (!isSucess) {
      showSnackBarMessage(
        context,
        Get.find<CancelTaskController>().errorMessage!,
        true,
      );
    }
  }
}
