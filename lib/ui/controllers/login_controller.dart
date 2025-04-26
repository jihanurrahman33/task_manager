import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

class LoginController extends GetxController {
  bool _loginUserInProgress = false;
  bool get loginInProgress => _loginUserInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<bool> loginUser(String email, String password) async {
    bool isSucess = false;
    _loginUserInProgress = true;
    update();
    Map<String, dynamic> requestBody = {"email": email, "password": password};
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSucess) {
      LoginModel loginModel = LoginModel.fromJson(response.data!);

      await AuthController.saveUserInformation(
        loginModel.token,
        loginModel.userModel,
      );
      isSucess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _loginUserInProgress = false;
    update();
    return isSucess;
  }
}
