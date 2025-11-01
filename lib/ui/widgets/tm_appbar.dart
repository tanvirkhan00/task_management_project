import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managenent/ui/controllers/auth_provider.dart';
import 'package:task_managenent/ui/Screen/login_screen.dart';
import 'package:task_managenent/ui/Screen/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile});

  final bool? fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromUpdateProfile ?? false) return;
          Navigator.pushNamed(context, UpdateProfileScreen.name);
        },
        child: Row(
          children: [
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 18,
              child: (user?.photo?.isNotEmpty ?? false)
                  ? Image.memory(jsonDecode(user!.photo!))
                  : const Icon(Icons.person),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.fullName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await context.read<AuthProvider>().clearUser();
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.name,
                  (predicate) => false,
            );
          },
          icon: const Icon(Icons.logout),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

