import 'package:flutter/material.dart';
import 'package:task_managenent/ui/Screen/forget_password_screen.dart';
import 'package:task_managenent/ui/Screen/login_screen.dart';
import 'package:task_managenent/ui/Screen/main_nav_holder_Screen.dart';
import 'package:task_managenent/ui/Screen/signup_screen.dart';
import 'package:task_managenent/ui/Screen/splash_screen.dart';
import 'package:task_managenent/ui/Screen/update_profile_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name : (_) => SplashScreen(),
        SignupScreen.name : (_) => SignupScreen(),
        LoginScreen.name : (_) => LoginScreen(),
        MainNavHolderScreen.name: (_) => MainNavHolderScreen(),
        UpdateProfileScreen.name: (_) => UpdateProfileScreen(),
        ForgetPasswordViaEmail.name : (_) => ForgetPasswordViaEmail(),
      },
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
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
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
        )
      ),
    );
  }
}
