import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_status_count_list_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/summary_card.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    _getAllTaskStatusCount();
    _getAllNewTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _getStatusCountInProgress == false,
              replacement: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CenteredCircularProgressIndicator(),
              ),
              child: _buildSummarySection(),
            ),
            GetBuilder<NewTaskController>(
              builder:
                  (controller) => Visibility(
                    visible: controller.getNewTaskInProgress == false,
                    replacement: SizedBox(
                      height: 300,
                      child: CenteredCircularProgressIndicator(),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          refreshList: _getAllNewTaskList,
                          onTaskDeleted: (task) async {
                            controller.newTaskList.removeWhere(
                              (t) => t.id == task.id,
                            );
                            await _getAllTaskStatusCount();
                            setState(() {});
                          },
                          taskStatus: TaskStatus.sNew,
                          taskModel: controller.newTaskList[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: controller.newTaskList.length,
                    ),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTask() async {
    final status = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
    if (status) {
      _getAllTaskStatusCount();
      _getAllNewTaskList();

      setState(() {});
    }
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _taskStatusCountList.length,
          itemBuilder: (context, index) {
            return SummaryCard(
              title: _taskStatusCountList[index].status,
              count: _taskStatusCountList[index].count,
            );
          },
        ),
      ),
    );
  }

  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    _getStatusCountInProgress = false;
    setState(() {});
    if (response.isSucess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data!);
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
  }

  Future<void> _getAllNewTaskList() async {
    final bool isSucess = await Get.find<NewTaskController>().getNewTaskList();
    if (!isSucess) {
      showSnackBarMessage(
        context,
        Get.find<NewTaskController>().errorMessage!,
        true,
      );
    }
  }
}
