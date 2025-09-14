import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/ui/widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ScreenBackground(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80,),
                      Text('Get Started With',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 24,),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email'
                        ),
                      ),
                      const SizedBox(height: 8,),
                      TextFormField(
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password'
                        ),
                      ),
                      const SizedBox(height: 8,),
                      FilledButton(onPressed: (){},
                          child: Icon(Icons.arrow_circle_right_outlined)),
                      const SizedBox( height: 36,),
                      Center(
                        child: Column(
                          children: [
                            TextButton(onPressed: (){} ,
                                child: Text('Forget Password', style: TextStyle(
                                  color: Colors.grey
                                ),)
                            ),
                            RichText(text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                              text: "Don't have any account? ",
                              children: [TextSpan(text: 'Sign Up', style: TextStyle(
                                color: Colors.green
                              ),
                                recognizer: TapGestureRecognizer()..onTap = () {}
                              )]
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
