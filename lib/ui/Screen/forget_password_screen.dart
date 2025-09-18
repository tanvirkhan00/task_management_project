import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/ui/Screen/pin_verification.dart';

import '../widgets/screen_background.dart';

class ForgetPasswordViaEmail extends StatefulWidget {
  const ForgetPasswordViaEmail({super.key});

  static const String name = '/passwordForget';

  @override
  State<ForgetPasswordViaEmail> createState() => _ForgetPasswordViaEmailState();
}

class _ForgetPasswordViaEmailState extends State<ForgetPasswordViaEmail> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "A 6 digit's verification will be send to your e-mail address",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _opTapEmailVerifybutton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        text: "Have Account? ",
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _ontapSignIn,
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _ontapSignIn() {
    Navigator.pop(context);
  }

  void _opTapEmailVerifybutton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PinVerificationScreen()),
    );
  }
}
