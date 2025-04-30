import 'package:get/state_manager.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class RegisterController extends GetxController {
  bool _registrationInProgress = false;
  bool get registrationInProgress => _registrationInProgress;
  bool isSuccess = false;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<bool> registerUser(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    _registrationInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );

    if (response.isSucess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage!;
    }
    _registrationInProgress = false;
    update();
    return isSuccess;
  }
}
