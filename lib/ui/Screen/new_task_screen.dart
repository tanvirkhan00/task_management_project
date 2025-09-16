import 'package:flutter/material.dart';
import 'package:task_managenent/ui/Screen/add_new_task_screen.dart';
import 'package:task_managenent/ui/widgets/task_count_card.dart';

import '../widgets/task-card.dart';

class Newtaskscreen extends StatefulWidget {
  const Newtaskscreen({super.key});

  @override
  State<Newtaskscreen> createState() => _NewtaskscreenState();
}

class _NewtaskscreenState extends State<Newtaskscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TCStatusCard(title: 'New', count: 05);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 08);
                },
              ),
            ),
            taskCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewTaskButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreen()));
  }
}

