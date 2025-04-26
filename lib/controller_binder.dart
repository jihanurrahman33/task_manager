import 'package:get/instance_manager.dart';
import 'package:task_manager/ui/controllers/cancel_task_controller.dart';
import 'package:task_manager/ui/controllers/complete_task_controller.dart';
import 'package:task_manager/ui/controllers/login_controller.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => CompleteTaskController());
    Get.lazyPut(() => CancelTaskController());
  }
}
