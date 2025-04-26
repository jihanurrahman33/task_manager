import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    _getAllProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProgressTaskController>(
        builder:
            (controller) => Visibility(
              visible: controller.getProgressTaskInProgress == false,
              replacement: CenteredCircularProgressIndicator(),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return TaskCard(
                    refreshList: _getAllProgressTaskList,
                    taskStatus: TaskStatus.progress,
                    taskModel: controller.ProgressTaskList[index],
                    onTaskDeleted: (task) async {
                      controller.ProgressTaskList.removeWhere(
                        (t) => t.id == task.id,
                      );
                      await _getAllProgressTaskList();
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: controller.ProgressTaskList.length,
              ),
            ),
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    final bool isSucess =
        await Get.find<ProgressTaskController>().getProgressTaskList();
    if (!isSucess) {
      showSnackBarMessage(
        context,
        Get.find<ProgressTaskController>().errorMessage!,
        true,
      );
    }
  }
}
