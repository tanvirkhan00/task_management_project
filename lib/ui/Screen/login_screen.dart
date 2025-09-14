import 'package:flutter/material.dart';
import 'package:task_managenent/ui/widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ScreenBackground(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80,),
                    Text('Get Started With', style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 24,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        hintStyle: TextStyle(
                          color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(),
                    const SizedBox(height: 8,),
                    FilledButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
                    TextButton(onPressed: (){} ,
                        child: Text('Forget Your Password')
                    ),
                    RichText(text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),
                      text: "Don't have any account",
                      children: [TextSpan(text: 'Sign Up')]
                    ))
                  ],
                ),
              ),
            )
        ),
    );
  }
}
