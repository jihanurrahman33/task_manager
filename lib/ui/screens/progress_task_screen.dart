import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTasksInProgress = false;
  List<TaskModel> _progressTaskList = [];
  @override
  void initState() {
    _getAllProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getProgressTasksInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return TaskCard(
              refreshList: _getAllProgressTaskList,
              taskStatus: TaskStatus.progress,
              taskModel: _progressTaskList[index],
              onTaskDeleted: (task) async {
                _progressTaskList.removeWhere((t) => t.id == task.id);
                await _getAllProgressTaskList();
                setState(() {});
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemCount: _progressTaskList.length,
        ),
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    _getProgressTasksInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.progressTaskListUrl,
    );
    if (response.isSucess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
    _getProgressTasksInProgress = false;
    setState(() {});
  }
}
