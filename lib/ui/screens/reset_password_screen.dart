import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/messenger.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String routeName = '/reset-password-screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isResetPasswordButtonInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const SizedBox(height: 16),

                Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Minimum length of password is 8 characters, at least one letter and one number',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _passwordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !_isPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
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
                      color: Colors.grey,
                    ),
                    hintText: 'New Password',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !_isConfirmPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      icon: _isConfirmPasswordVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      color: Colors.grey,
                    ),
                    hintText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (value != _passwordTEController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _onTapResetPasswordButton,
                  child: _isResetPasswordButtonInProgress
                      ? CenteredCircularProgressIndicator()
                      : Text('Reset Password'),
                ),
                const SizedBox(height: 24),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(color: Colors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignInButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  void _onTapResetPasswordButton() {
    _resetPassword();
  }

  Future<void> _resetPassword() async {
    _isResetPasswordButtonInProgress = true;
    setState(() {});

    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final String email = args['email'];
    final String otp = args['otp'];

    Map<String, dynamic> requestBody = {
      'email': email,
      'OTP': otp,
      'password': _passwordTEController.text,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.resetPasswordUrl,
      body: requestBody,
    );

    _isResetPasswordButtonInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      if (!mounted) return;
      Messenger.showSuccessMessage(context, response.body['data']);
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.routeName,
        (route) => false,
      );
    } else {
      if (!mounted) return;
      Messenger.showErrorMessage(context, response.errorMessage);
    }
  }
}
