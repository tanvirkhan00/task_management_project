import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/ui/Screen/login_screen.dart';

import '../widgets/screen_background.dart';


class Setnewpassword extends StatefulWidget {
  const Setnewpassword({super.key});

  @override
  State<Setnewpassword> createState() => _SetnewpasswordState();
}

class _SetnewpasswordState extends State<Setnewpassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
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
                    const SizedBox(height: 80,),
                    Text('Set New Password',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('Password should be more that 6 and combinations all characters', style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'New Password'
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: _confirmpassController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password'
                      ),
                    ),
                    const SizedBox(height: 8,),
                    FilledButton(onPressed: (){},
                        child: Icon(Icons.arrow_circle_right_outlined)),
                    const SizedBox( height: 36,),
                    Center(
                      child: Column(
                        children: [
                          RichText(text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                              ),
                              text: "Already have an account? ",
                              children: [TextSpan(text: 'Sign In', style: TextStyle(
                                  color: Colors.green
                              ),
                                  recognizer: TapGestureRecognizer()..onTap = _OntapSignIn
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

  void _OntapSignIn() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
  }


  @override
  void dispose() {
    _passwordController.dispose();
    _confirmpassController.dispose();
    super.dispose();
  }

}
