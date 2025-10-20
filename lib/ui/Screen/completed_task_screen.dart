import 'package:flutter/material.dart';
import 'package:task_managenent/data/models/task_model.dart';
import 'package:task_managenent/data/services/apiCaller.dart';
import 'package:task_managenent/data/utils/urls.dart';
import 'package:task_managenent/ui/widgets/snack_bar_message.dart';
import 'package:task_managenent/ui/widgets/task-card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  static const String name = '/dashboard';

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTask = [];
  bool _completedTaskInProgress = false;



  @override
  void initState() {
    super.initState();
    _getAllCompletedTask();
  }

  Future<void> _getAllCompletedTask() async {
    _completedTaskInProgress = true;
    setState(() {});

    final ApiResponse response = await apiCaller.getRequest(
      url: Urls.completedTaskListUrl,
    );
    if(response.isSuccess) {
      List<TaskModel> list =[];
      for(Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTask = list ;
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
    _completedTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _completedTaskInProgress == false,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: _completedTask.length,
          itemBuilder: (context, index) {
            return taskCard(
              taskModel: _completedTask[index],
              refreshParent: () {
                _getAllCompletedTask();
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
        ),
      ),
    );
  }
}
