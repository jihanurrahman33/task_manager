import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _getCanceledTasksInProgress = false;
  List<TaskModel> _CanceledTaskList = [];
  @override
  void initState() {
    _getAllCanceledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCanceledTasksInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return TaskCard(
              refreshList: _getAllCanceledTaskList,
              taskStatus: TaskStatus.canceled,
              taskModel: _CanceledTaskList[index],
              onTaskDeleted: (task) async {
                _CanceledTaskList.removeWhere((t) => t.id == task.id);
                await _getAllCanceledTaskList();
                setState(() {});
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemCount: _CanceledTaskList.length,
        ),
      ),
    );
  }

  Future<void> _getAllCanceledTaskList() async {
    _getCanceledTasksInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.canceledTaskListUrl,
    );
    if (response.isSucess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _CanceledTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
    _getCanceledTasksInProgress = false;
    setState(() {});
  }
}
