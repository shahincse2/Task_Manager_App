import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/messenger.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/forgot_password_otp_verify_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String routeName = '/forgot-password-email-screen';

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isEmailSubmissionInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              key: _formKey,
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
                TextFormField(
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: true,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _onTapEmailSubmitButton,
                  child: _isEmailSubmissionInProgress
                      ? CenteredCircularProgressIndicator()
                      : Text('Send OTP'),
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

  void _onTapEmailSubmitButton() {
    _sendEmail();
  }

  Future<void> _sendEmail() async {
    _isEmailSubmissionInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.emailVerifyUrl(_emailTEController.text.trim()),
    );
    _isEmailSubmissionInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      if (!mounted) return;
      Navigator.pushNamed(context, ForgotPasswordOtpVerifyScreen.routeName, arguments: _emailTEController.text.trim());
      Messenger.showSuccessMessage(context, response.body['data']);
    } else {
      if (!mounted) return;
      Messenger.showErrorMessage(context, response.errorMessage);
    }
  }
}
