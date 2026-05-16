import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/core/constants/messenger.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordOtpVerifyScreen extends StatefulWidget {
  const ForgotPasswordOtpVerifyScreen({super.key});

  static const String routeName = '/forgot-password-pin-verify-screen';

  @override
  State<ForgotPasswordOtpVerifyScreen> createState() =>
      _ForgotPasswordOtpVerifyScreenState();
}

class _ForgotPasswordOtpVerifyScreenState
    extends State<ForgotPasswordOtpVerifyScreen> {
  bool _isVerifyPasswordButtonInProgress = false;
  String _otp = '';

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
                              style: TextStyle(
                                fontSize: 24,
                                color: cell.isFocused
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                onCompleted: (pin) {
                  _otp = pin;
                },
              ),

              const SizedBox(height: 8),
              FilledButton(
                onPressed: _onTapVerifyOtpButton,
                child: _isVerifyPasswordButtonInProgress
                    ? CenteredCircularProgressIndicator()
                    : Text('Verify'),
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

  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  void _onTapVerifyOtpButton() {
    _verifyOtp();
  }

  Future<void> _verifyOtp() async {
    _isVerifyPasswordButtonInProgress = true;
    setState(() {});

    if (_otp.length != 6) {
      Messenger.showErrorMessage(context, 'Enter your 6 digit OTP');
      return;
    }

    final String email = ModalRoute.of(context)!.settings.arguments as String;

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.verifyOtpUrl(email, _otp),
    );

    _isVerifyPasswordButtonInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      if (!mounted) return;
      Messenger.showSuccessMessage(context, response.body['data']);
      Navigator.pushNamed(
        context,
        ResetPasswordScreen.routeName,
        arguments: {'email': email, 'otp': _otp},
      );
    } else {
      if (!mounted) return;
      Messenger.showErrorMessage(context, response.errorMessage);
    }
  }
}
