import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompleteTasksInProgress = false;
  List<TaskModel> _completedTaskList = [];
  @override
  void initState() {
    _getAllCompleteTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return TaskCard(
            taskStatus: TaskStatus.completed,
            taskModel: _completedTaskList[index],
            onTaskDeleted: (TaskModel) {},
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: _completedTaskList.length,
      ),
    );
  }

  Future<void> _getAllCompleteTaskList() async {
    _getCompleteTasksInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completedTaskListUrl,
    );
    if (response.isSucess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
    _getCompleteTasksInProgress = false;
    setState(() {});
  }
}
