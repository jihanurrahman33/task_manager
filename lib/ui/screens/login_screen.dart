import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_verify_email.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/register_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObsecure = true;
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
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: _isObsecure,
                  controller: _passwordTEController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObsecure = !_isObsecure;
                        });
                      },
                      icon:
                          _isObsecure
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.remove_red_eye_outlined),
                    ),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onTapSignInButton,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPasswordButton,
                        child: Text('Forgot Password'),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(text: 'Don\'t Have Account?'),
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = _onTapSignUpButton,
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
      MaterialPageRoute(builder: (context) => MainBottomNavScreen()),
      (predicate) => false,
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordVerifyEmailScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
