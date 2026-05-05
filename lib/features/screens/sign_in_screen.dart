import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/screens/sign_up_screen.dart';
import 'package:task_manager/features/widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

              const Text(
                'Get Started With',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              TextFormField(decoration: InputDecoration(hintText: 'Password')),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _onTapSignInButton,
                child: Icon(Icons.arrow_circle_right_outlined),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _onTapForgotButton,
                      child: Text('Forgot Password?'),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUpButton
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapForgotButton() {}
  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }
  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }
}
