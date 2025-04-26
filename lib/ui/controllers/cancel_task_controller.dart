import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class CancelTaskController extends GetxController {
  List<TaskModel> _cancelTaskList = [];
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get cancelTaskList => _cancelTaskList;
  bool _getCancelTasksInProgress = false;
  bool get getCancelTasksInProgress => _getCancelTasksInProgress;
  bool isSucess = false;
  Future<bool> getAllCancelTaskList() async {
    _getCancelTasksInProgress = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.canceledTaskListUrl,
    );
    if (response.isSucess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _cancelTaskList = taskListModel.taskList;
      isSucess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSucess = false;
    }
    _getCancelTasksInProgress = false;
    update();
    return isSucess;
  }
}
