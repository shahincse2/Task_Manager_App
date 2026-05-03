import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/splash_screens.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreens(),
    );
  }
}
