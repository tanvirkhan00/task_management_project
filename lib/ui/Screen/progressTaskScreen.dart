import 'package:flutter/material.dart';
import 'package:task_managenent/ui/widgets/task_count_card.dart';

import '../widgets/task-card.dart';

class Progresstaskscreen extends StatefulWidget {
  const Progresstaskscreen({super.key});

  @override
  State<Progresstaskscreen> createState() => _ProgresstaskscreenState();
}

class _ProgresstaskscreenState extends State<Progresstaskscreen> {
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
    );
  }
}

