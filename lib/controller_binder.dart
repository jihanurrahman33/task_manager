import 'package:get/instance_manager.dart';
import 'package:task_manager/ui/controllers/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
