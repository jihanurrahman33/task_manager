import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/fcm_service.dart';
import 'package:task_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FcmService().init();
  print(await FcmService().getFcmToken());
  runApp(const TaskManagerApp());
}
