import 'package:flutter/material.dart';
import 'package:task_manager/features/screens/forgot_password_email_screen.dart';
import 'package:task_manager/features/screens/forgot_password_otp_verify_screen.dart';
import 'package:task_manager/features/screens/reset_password_screen.dart';
import 'package:task_manager/features/screens/sign_in_screen.dart';
import 'package:task_manager/features/screens/sign_up_screen.dart';
import 'package:task_manager/features/screens/splash_screens.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      initialRoute: SplashScreens.routeName,
      routes: <String, WidgetBuilder>{
        SignInScreen.routeName: (BuildContext context) => SignInScreen(),
        SignUpScreen.routeName: (BuildContext context) => SignUpScreen(),
        ForgotPasswordEmailScreen.routeName: (BuildContext context) => ForgotPasswordEmailScreen(),
        ForgotPasswordPOtpVerifyScreen.routeName: (BuildContext context) => ForgotPasswordPOtpVerifyScreen(),
        ResetPasswordScreen.routeName: (BuildContext context) => ResetPasswordScreen(),
      },
      home: SplashScreens(),
    );
  }
}
