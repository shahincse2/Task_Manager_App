import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/asset_paths.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = await AuthController.isAlreadyUserLoggedIn();
    if (isLoggedIn) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, MainBottomNavBarScreen.routeName);
    } else {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
      child: Center(child: SvgPicture.asset(AssetPaths.logoSVG, width: 120)),
    );
  }
}
