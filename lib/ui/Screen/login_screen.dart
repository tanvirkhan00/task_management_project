import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/data/services/apiCaller.dart';
import 'package:task_managenent/data/utils/urls.dart';
import 'package:task_managenent/ui/Screen/main_nav_holder_Screen.dart';
import 'package:task_managenent/ui/Screen/signup_screen.dart';
import 'package:task_managenent/ui/widgets/screen_background.dart';
import 'package:task_managenent/ui/widgets/snack_bar_message.dart';

import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loginInProgress = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    validator: (String? value) {
                      String inputText = value ?? "";
                      if (EmailValidator.validate(inputText) == false) {
                        return "Enter a Valid Email";
                      } else {
                        return null ;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passController,
                    validator: (String? value) {
                      if((value?.length ?? 0) <= 6) {
                        return "Password should be more that 6 digit";
                      } else {
                        return null ;
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: _loginInProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: FilledButton(
                      onPressed: _mainNavHolderScreenButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgetPassword,
                          child: Text(
                            'Forget Password',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            text: "Don't have any account? ",
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _signUpTab,
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
      ),
    );
  }

  void _signUpTab() {
    Navigator.pushNamed(context, SignupScreen.name);
  }

  void _onTapForgetPassword() {
    Navigator.pushNamed(context, ForgetPasswordViaEmail.name);
  }

  void _mainNavHolderScreenButton() {
    if(_formKey.currentState!.validate()) {
      _login();
    }
  }

  Future<void> _login() async {
    _loginInProgress = true ;
    setState(() {});

    Map<String, dynamic> requestBody = {

        "email":_emailController.text.trim(),
        "password":_passController.text
    };
    final ApiResponse response = await apiCaller.postRequest(url: Urls.loginUrl,
    body: requestBody
    );
    if(response.isSuccess && response.responseData['status'] == 'success') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavHolderScreen.name,
        (predicate) => false,
      );
    } else {
      _loginInProgress = false ;
      setState(() { });
      showSnakbarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
