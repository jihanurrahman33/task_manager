import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ForgotPasswordPinVerificationScreen extends StatefulWidget {
  const ForgotPasswordPinVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<ForgotPasswordPinVerificationScreen> createState() =>
      _ForgotPasswordPinVerificationScreenState();
}

class _ForgotPasswordPinVerificationScreenState
    extends State<ForgotPasswordPinVerificationScreen> {
  final TextEditingController _pinCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _recoverVerifyOtpInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 80),
                Text(
                  'Pin Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'A 6 Digit verification pin has been sent to your email.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                PinCodeTextField(
                  controller: _pinCodeTEController,

                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    activeColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,

                  appContext: context,
                ),
                const SizedBox(height: 8),

                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: Visibility(
                    visible: _recoverVerifyOtpInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: Text('Verify'),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(text: 'Have an account?'),
                            TextSpan(
                              text: ' Sign in',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = _onTapSignInButton,
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
      ),
    );
  }

  void _onTapSubmitButton() async {
    _recoverVerifyOtpInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.recoverVerifyOtpUrl(widget.email, _pinCodeTEController.text),
    );
    _recoverVerifyOtpInProgress = false;
    setState(() {});
    if (response.isSucess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ResetPasswordScreen(
                email: widget.email,
                otp: _pinCodeTEController.text,
              ),
        ),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (pre) => false,
    );
  }

  @override
  void dispose() {
    _pinCodeTEController.dispose();
    super.dispose();
  }
}
