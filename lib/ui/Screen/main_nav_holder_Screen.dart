import 'package:flutter/material.dart';
import 'package:task_managenent/ui/Screen/new_task_screen.dart';
import 'package:task_managenent/ui/Screen/progressTaskScreen.dart';
import 'package:task_managenent/ui/widgets/tm_appbar.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = '/dashboard';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Newtaskscreen(),
    Progresstaskscreen(),
    Progresstaskscreen(),
    Progresstaskscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.new_label_outlined), label: 'New'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancelled'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          ] ),
    );
  }
}

