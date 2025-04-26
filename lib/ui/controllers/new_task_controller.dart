import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  bool get getNewTaskInProgress => _getNewTaskInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSucess = false;

    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.newTaskListUrl,
    );

    if (response.isSucess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
      isSucess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getNewTaskInProgress = false;
    update();
    return isSucess;
  }
}
