import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';

import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<String, dynamic>? task;
  @override
  void initState() {
    _taskStatusCount();
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool isLoggedIn = await AuthController.checkIfUserLoggedIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => isLoggedIn ? MainBottomNavScreen() : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: Text('Nishak', style: TextStyle(fontSize: 30))),
      ),
    );
  }

  Future<void> _taskStatusCount() async {
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSucess) {
      task = response.data;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }
}
