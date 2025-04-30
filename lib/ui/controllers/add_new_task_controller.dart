import 'package:get/state_manager.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _addNewTaskInProgress = false;
  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool isSuccess = false;
  Future<bool> addNewTask(String title, String description) async {
    _addNewTaskInProgress = true;
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
    };
    update();
    final NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.createTaskUrl,
      body: requestBody,
    );

    if (response.isSucess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
