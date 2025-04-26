import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  bool get getProgressTaskInProgress => _getProgressTaskInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _ProgressTaskList = [];
  List<TaskModel> get ProgressTaskList => _ProgressTaskList;

  Future<bool> getProgressTaskList() async {
    bool isSucess = false;

    _getProgressTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.progressTaskListUrl,
    );

    if (response.isSucess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _ProgressTaskList = taskListModel.taskList;
      isSucess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getProgressTaskInProgress = false;
    update();
    return isSucess;
  }
}
