import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          filled: true,
          border: _getZeroBorder(),
          errorBorder: _getZeroBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            iconColor: Colors.white,
            iconSize: 30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      home: SplashScreen(),
    );
  }

  OutlineInputBorder _getZeroBorder() {
    return OutlineInputBorder(borderSide: BorderSide.none);
  }
}
