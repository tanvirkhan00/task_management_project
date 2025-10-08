import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/ui/Screen/login_screen.dart';
import 'package:task_managenent/ui/Screen/update_profile_screen.dart';
import 'package:task_managenent/ui/controllers/auth-controller.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile});

  final bool? fromUpdateProfile;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if(widget.fromUpdateProfile ?? false) {
            return ;
          }
          Navigator.pushNamed(
            context, UpdateProfileScreen.name,
          );
        },
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.FullName ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
                Text(
                  AuthController.userModel?.email?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [IconButton(onPressed: _signOut, icon: Icon(Icons.logout))],
    );
  }

  Future<void> _signOut() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.name, (predicate) => false);
  }
}
