import 'package:flutter/material.dart';
import 'package:task_managenent/data/models/task_model.dart';
import 'package:task_managenent/data/models/task_status_count_model.dart';
import 'package:task_managenent/data/services/apiCaller.dart';
import 'package:task_managenent/data/utils/urls.dart';
import 'package:task_managenent/ui/Screen/add_new_task_screen.dart';
import 'package:task_managenent/ui/widgets/snack_bar_message.dart';
import 'package:task_managenent/ui/widgets/task_count_card.dart';

import '../widgets/task-card.dart';

class Newtaskscreen extends StatefulWidget {
  const Newtaskscreen({super.key});

  @override
  State<Newtaskscreen> createState() => _NewtaskscreenState();
}

class _NewtaskscreenState extends State<Newtaskscreen> {

  bool _getStatusCountInProgress = false ;
  bool _getNewTaskInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addNewTaskStatusCount();
    _getAllNewTask();
  }

  Future<void> _addNewTaskStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response = await apiCaller.getRequest(url: Urls.statatusCount);
    if(response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list ;
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }
  Future<void> _getAllNewTask() async {
    _getNewTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await apiCaller.getRequest(url: Urls.newTaskListUrl);
    if(response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list ;
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }

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
              child: Visibility(
                visible: _getStatusCountInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TCStatusCard(title: _taskStatusCountList[index].status,
                        count: _taskStatusCountList[index].count);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 08);
                  },
                ),
              ),
            ),
            Expanded(
                child: Visibility(
              visible: _getNewTaskInProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
                  child: ListView.separated(
                  itemCount: _newTaskList.length,
                    itemBuilder: (context, index) {
                    return taskCard(taskModel: _newTaskList[index],
                    refreshParent: () {
                      _getAllNewTask();
                    },);
                    },
                    separatorBuilder: (context,index) {
                     return SizedBox( height: 8,);
                    },
                  ),
            )
            )
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

