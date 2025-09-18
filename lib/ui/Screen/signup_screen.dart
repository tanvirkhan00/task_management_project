import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/ui/Screen/main_nav_holder_Screen.dart';

import '../widgets/screen_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _fnameEditingController = TextEditingController();
  final TextEditingController _lnameEditingController = TextEditingController();
  final TextEditingController _numberEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Join with Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailEditingController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _fnameEditingController,
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lnameEditingController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _numberEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Phone'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordEditingController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _onTapMainNavHolderButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _ontaploginButton,
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

  void _ontaploginButton() {
    Navigator.pop(context);
  }

  void _onTapMainNavHolderButton() {
    Navigator.pushNamedAndRemoveUntil(
      context, MainNavHolderScreen.name,
      (predicate) => false,
    );
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _fnameEditingController.dispose();
    _lnameEditingController.dispose();
    _numberEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}
