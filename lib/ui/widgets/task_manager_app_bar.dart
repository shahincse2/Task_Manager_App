import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfileScreen = false});

  final bool fromUpdateProfileScreen;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      foregroundColor: Colors.white,
      titleSpacing: 0,
      leading: GestureDetector(
        onTap: _canPop,
        child: SizedBox(
          width: 60,
          child: Icon(Icons.arrow_back_outlined, color: Colors.white, size: 28),
        ),
      ),
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromUpdateProfileScreen) return;
          Navigator.pushNamed(context, UpdateProfileScreen.routeName);
        },
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: AuthController.user!.photo.isEmpty
                  ? Icon(Icons.person)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                    child: Image.memory(
                        base64Decode(AuthController.user!.photo),
                        fit: BoxFit.cover,
                      ),
                  ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.user?.fullName ?? '',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  AuthController.user?.email ?? '',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthController.clearUserData();
            if (!context.mounted) return;
            Navigator.pushNamedAndRemoveUntil(
              context,
              SignInScreen.routeName,
              (predicate) => false,
            );
          },
          icon: Icon(Icons.logout_outlined, color: Colors.white),
        ),
      ],
    );
  }

  void _canPop() {
    if (Navigator.canPop(TaskManagerApp.navigatorKey.currentContext!)) {
      Navigator.pop(TaskManagerApp.navigatorKey.currentContext!);
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
