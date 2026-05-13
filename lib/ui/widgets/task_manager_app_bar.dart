import 'package:flutter/material.dart';
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
      automaticallyImplyLeading: true,
      foregroundColor: Colors.white,
      leadingWidth: 20,
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if(fromUpdateProfileScreen) return;
          Navigator.pushNamed(context, UpdateProfileScreen.routeName);
        },
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sadek Hasan',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  'sadek@gmail.com',
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
            if(!context.mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (predicate) => false);
          },
          icon: Icon(Icons.logout_outlined, color: Colors.white,),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
