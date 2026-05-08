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
  XFile? pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        pickedImage = image;
      });
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
                  decoration: InputDecoration(
                    hintText: 'Select Photo',

                    prefixIcon: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        color: Colors.black,

                        child: const Text(
                          'Photos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
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
