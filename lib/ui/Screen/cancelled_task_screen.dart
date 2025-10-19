import 'package:flutter/material.dart';
import 'package:task_managenent/data/models/task_model.dart';
import 'package:task_managenent/data/services/apiCaller.dart';
import 'package:task_managenent/data/utils/urls.dart';
import 'package:task_managenent/ui/widgets/snack_bar_message.dart';
import 'package:task_managenent/ui/widgets/task-card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  static const String name = '/dashboard';

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  List<TaskModel> _cancelledTask = [];
  bool _cancelledTaskInProgress = false ;

  @override
  void initState() {
    super.initState();
    _getAllCancelledTask();
  }

  Future<void> _getAllCancelledTask() async {
    _cancelledTaskInProgress = true ;
    setState(() {});
    final ApiResponse response = await apiCaller.getRequest(
      url: Urls.cancelledTaskListUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTask = list;
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
    _cancelledTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _cancelledTaskInProgress == false,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: _cancelledTask.length,
          itemBuilder: (context, index) {
            return taskCard(
              taskModel: _cancelledTask[index],
              refreshParent: () {
                _getAllCancelledTask();
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
        ),
      ),
    );
  }
}
