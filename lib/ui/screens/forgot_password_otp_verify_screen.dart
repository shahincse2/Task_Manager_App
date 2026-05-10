import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordPOtpVerifyScreen extends StatefulWidget {
  const ForgotPasswordPOtpVerifyScreen({super.key});

  static const String routeName = '/forgot-password-pin-verify-screen';

  @override
  State<ForgotPasswordPOtpVerifyScreen> createState() =>
      _ForgotPasswordPOtpVerifyScreenState();
}

class _ForgotPasswordPOtpVerifyScreenState
    extends State<ForgotPasswordPOtpVerifyScreen> {
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
                'Verify Your Email Address',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              Text(
                'A 6 digit verification code has been send to your email address',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const SizedBox(height: 8),

              PinInput(
                length: 6,
                autoFocus: true,
                obscureText: true,
                obscuringCharacter: '*',
                builder: (context, cells) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cells.map((cell) {
                      return Expanded(
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: cell.isFocused
                                ? Colors.blue
                                : Colors.grey[200],
                          ),
                          child: Center(
                            child: Text(
                              cell.character ?? '',
                              style: TextStyle(fontSize: 24, color: cell.isFocused ? Colors.white : Colors.black,),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                onCompleted: (pin) => print('PIN: $pin'),
              ),

              const SizedBox(height: 8),
              FilledButton(
                onPressed: _onTapVerifyPasswordButton,
                child: Text('Verify'),
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
    );
  }

  void _onTapVerifyPasswordButton() {
    Navigator.pushNamedAndRemoveUntil(context, ResetPasswordScreen.routeName, (route) => false);
  }

  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
}
