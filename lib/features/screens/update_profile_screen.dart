import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/features/screens/forgot_password_email_screen.dart';
import 'package:task_manager/features/widgets/screen_background.dart';
import 'package:task_manager/features/widgets/task_manager_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String routeName = '/update-profile-screen';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? selectedImage;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
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
                TextFormField(
                  readOnly: true,

                  decoration: InputDecoration(
                    hintText: 'Select Photo',

                    prefixIcon: GestureDetector(
                      onTap: _pickImage,

                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8),),
                        ),
                        child: const Text(
                          'Photos',
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (selectedImage != null)
                  Image.file(
                    selectedImage!,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
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
                  onPressed: _moveToPinVerificationScreen,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _moveToPinVerificationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordEmailScreen()),
    );
  }
}
