import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managenent/ui/Screen/login_screen.dart';
import 'package:task_managenent/ui/Screen/main_nav_holder_Screen.dart';
import 'package:task_managenent/ui/controllers/auth-controller.dart';
import 'package:task_managenent/ui/utils/asset_path.dart';
import 'package:task_managenent/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveNextScreen();
  }


  Future<void> _moveNextScreen () async {
    await Future.delayed(Duration(seconds: 1));
    final bool isLoggedIn = await AuthController.isUserAlreadyLoggedIn();
    if (isLoggedIn) {
       AuthController.getUserData();
      Navigator.pushReplacementNamed(context, MainNavHolderScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(AssetPaths.logoImage, height: 60,),
        
        ),
      ),
    );
  }
}
