import 'package:email_validator/email_validator.dart';
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
  final TextEditingController _numberEditingController =TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  bool _singupInProgress = false ;

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
                    'Join with Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailEditingController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String inputText= value ?? '' ;
                      if(EmailValidator.validate(inputText) == false) {
                        return "Enter a valid e-mail";
                      } else {
                        return null ;
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _fnameEditingController,
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if(value?.trim().isEmpty ?? true) {
                        return "Enter your first name";
                      } else {
                        return null ;
                      }
                    },
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _lnameEditingController,
                    validator: (String? value) {
                      if(value?.trim().isEmpty ?? true) {
                        return "Enter your last name";
                      } else {
                        return null ;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _numberEditingController,
                    validator: (String? value) {
                      if(value?.trim().isEmpty ?? true) {
                        return "Enter your number";
                      } else {
                        return null ;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Phone'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordEditingController,
                    validator: (String? value) {
                      if((value?.length ?? 0) <= 6) {
                        return "Enter a password more that 6";
                      } else {
                        return null ;
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _onTapSubmitButton,
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

  void _onTapSubmitButton () {
    if (_formKey.currentState!.validate()) {
      // todo: register this user
    }
  }

  void _ontaploginButton() {
    Navigator.pop(context);
  }

  Future<void> _signup() async {
    _singupInProgress = true ;
    setState(() {});
    Map<String, dynamic> requestBody ={
        "email":_emailEditingController.text.trim(),
        "firstName":_fnameEditingController.text.trim(),
        "lastName":_lnameEditingController.text.trim(),
        "mobile":_numberEditingController.text.trim(),
        "password":_passwordEditingController.text
    };
  }

  // void _onTapMainNavHolderButton() {
  //   Navigator.pushNamedAndRemoveUntil(
  //     context, MainNavHolderScreen.name,
  //     (predicate) => false,
  //   );
  // }

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
