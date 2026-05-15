import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_otp_verify_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String routeName = '/forgot-password-email-screen';

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  bool _isEmailSubmitionInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              const SizedBox(height: 16),

              Text(
                'Your Email Address',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              Text(
                'A 6 digit verification code will be sent to your email address',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const SizedBox(height: 8),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _onTapEmailSubmitButton,
                child: _isEmailSubmitionInProgress ? CenteredCircularProgressIndicator() : Icon(Icons.arrow_circle_right_outlined),
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
                            ..onTap = _onTapSignInButton
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _onTapEmailSubmitButton() {
    _isEmailSubmitionInProgress = true;
    setState(() {});
    Navigator.pushNamed(context, ForgotPasswordPOtpVerifyScreen.routeName);
  }

  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
}
