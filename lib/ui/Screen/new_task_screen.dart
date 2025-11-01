import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managenent/ui/Screen/add_new_task_screen.dart';
import 'package:task_managenent/ui/controllers/new_task_list_provider.dart';
import 'package:task_managenent/ui/controllers/task_count_provider.dart';
import 'package:task_managenent/ui/widgets/task_count_card.dart';

import '../widgets/task-card.dart';

class Newtaskscreen extends StatefulWidget {
  const Newtaskscreen({super.key});

  @override
  State<Newtaskscreen> createState() => _NewtaskscreenState();
}

class _NewtaskscreenState extends State<Newtaskscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewTaskListProvider>().getNewTasks();
    context.read<TaskCountProvider>().getTaskCount();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<TaskCountProvider>(
          builder: (context, taskCountProvider, _) {
            return Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: Visibility(
                    visible: taskCountProvider.getStatusCountInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.separated(
                      itemCount: taskCountProvider.taskStatusCountList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TCStatusCard(
                          title: taskCountProvider.taskStatusCountList[index].status,
                          count: taskCountProvider.taskStatusCountList[index].count,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<NewTaskListProvider>(
                    builder: (context, newTaskListProvider, _) {
                      return Visibility(
                        visible:
                            newTaskListProvider.getNewTaskInProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ListView.separated(
                          itemCount: newTaskListProvider.newTaskList.length,
                          itemBuilder: (context, index) {
                            return taskCard(
                              taskModel: newTaskListProvider.newTaskList[index],
                              refreshParent: () {
                                context.read<NewTaskListProvider>().getNewTasks();
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 8);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
  }
}
