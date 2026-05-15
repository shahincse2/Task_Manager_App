import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/core/constants/messenger.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/photo_picker.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_manager_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String routeName = '/update-profile-screen';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isUpdateProfileInProgress = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  @override
  void initState() {
    // TODO: implement initState
    final UserModel user = AuthController.user!;

    _emailTEController.text = user.email;
    _firstNameTEController.text = user.firstName;
    _lastNameTEController.text = user.lastName;
    _mobileTEController.text = user.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromUpdateProfileScreen: true),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    onTap: _pickImage,
                    child: PhotoPicker(pickedImage: _pickedImage),
                  ),

                  const Divider(color: Colors.grey),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Email is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter your first name.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter your first last name.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    validator: (value) {
                      String mobileNumber = value ?? '';
                      if (mobileNumber.isNotEmpty && mobileNumber.length < 11) {
                        return 'Enter your mobile number.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: _isPasswordVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      String password = value ?? '';
                      if (password.isNotEmpty && password.length < 6) {
                        return 'Password must be at least 6 characters.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _onTapUpdateProfileButton,
                    child: _isUpdateProfileInProgress ? Center(child: CenteredCircularProgressIndicator()) : Text('Update Profile'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  void _onTapUpdateProfileButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isUpdateProfileInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }

    if(_pickedImage != null) {
      Uint8List imageBytes = await _pickedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    final NetworkResponse response = await NetworkCaller.patchRequest(
      Urls.profileUpdateUrl,
      body: requestBody,
    );

    setState(() {
      _isUpdateProfileInProgress = false;
    });

    if (response.isSuccess) {
      final responseBody = response.body;

      if (responseBody != null && responseBody['data'] != null) {
        UserModel updatedUser = UserModel.fromJson(responseBody['data']);
        await AuthController.updateUserData(updatedUser);
      }

      if (!mounted) return;
      Messenger.showSuccessMessage(context, 'Profile updated successfully!');
      Navigator.pop(context, true);
    } else {
      if (!mounted) return;
      Messenger.showErrorMessage(context, response.errorMessage);
    }
  }
}
