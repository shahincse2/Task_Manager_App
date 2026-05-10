import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/app_colors.dart';

class Messenger {
  static void showSnackBarMessage(
      BuildContext context,
      String message, {
        Duration duration = const Duration(seconds: 2),
        Color backgroundColor = Colors.green,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void showErrorMessage(BuildContext context, String message) {
    showSnackBarMessage(context, message, backgroundColor: AppColors.error);
  }

  static void showSuccessMessage(BuildContext context, String message) {
    showSnackBarMessage(context, message, backgroundColor:  AppColors.success);
  }

  static void showInfoMessage(BuildContext context, String message) {
    showSnackBarMessage(context, message, backgroundColor:  AppColors.info);
  }
}