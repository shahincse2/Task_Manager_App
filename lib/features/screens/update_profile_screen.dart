import 'package:flutter/material.dart';
import 'package:task_manager/features/widgets/photo_picker.dart';
import 'package:task_manager/features/widgets/screen_background.dart';
import 'package:task_manager/features/widgets/task_manager_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String routeName = '/update-profile-screen';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromUpdateProfileScreen: true),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const SizedBox(height: 16),

                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: _onTapChoosePhotoButton,
                  child: PhotoPicker(),
                ),

                TextFormField(decoration: InputDecoration(hintText: 'Email')),
                TextFormField(
                  decoration: InputDecoration(hintText: 'First Name'),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Last Name'),
                ),
                TextFormField(decoration: InputDecoration(hintText: 'Mobile')),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _onTapUpdateProfileButton,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapChoosePhotoButton() {
    //TODO: Photo Picker Button
  }

  void _onTapUpdateProfileButton() {
    //TODO: Update Profile Screen
  }
}
