import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmNewPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObsecure1 = true;
  bool _isObsecure2 = true;
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
                  'Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Set a new password minimum length of 6 letters.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: _isObsecure1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObsecure1 = !_isObsecure1;
                        });
                      },
                      icon:
                          _isObsecure1
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: _isObsecure2,
                  decoration: InputDecoration(
                    hintText: 'Confidm New Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObsecure2 = !_isObsecure2;
                        });
                      },
                      icon:
                          _isObsecure2
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: Text('Confirm'),
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

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (pre) => false,
    );
  }

  void _onTapSubmitButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (pre) => false,
    );
  }

  void _onTapForgotPasswordButton() {}

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();
    super.dispose();
  }
}
