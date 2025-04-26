import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class CompleteTaskController extends GetxController {
  List<TaskModel> _completedTaskList = [];
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get completedTaskList => _completedTaskList;
  bool _getCompleteTasksInProgress = false;
  bool get getCompleteTasksInProgress => _getCompleteTasksInProgress;
  bool isSucess = false;
  Future<bool> getAllCompleteTaskList() async {
    _getCompleteTasksInProgress = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completedTaskListUrl,
    );
    if (response.isSucess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList;
      isSucess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSucess = false;
    }
    _getCompleteTasksInProgress = false;
    update();
    return isSucess;
  }
}
