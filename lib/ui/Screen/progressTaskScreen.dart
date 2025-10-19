import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/services/apiCaller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task-card.dart';

class Progresstaskscreen extends StatefulWidget {
  const Progresstaskscreen({super.key});

  static const String name = '/dashboard';

  @override
  State<Progresstaskscreen> createState() => _ProgresstaskscreenState();
}

class _ProgresstaskscreenState extends State<Progresstaskscreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllProgressTask();
  }

  Future<void> _getAllProgressTask() async {
    _getProgressTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await apiCaller.getRequest(
      url: Urls.progressTaskListUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
    _getProgressTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: _getProgressTaskInProgress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: _progressTaskList.length,
            itemBuilder: (context, index) {
              return taskCard(
                taskModel: _progressTaskList[index],
                refreshParent: () {
                  _getAllProgressTask();
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
          ),
        ),
      ),
    );
  }
}
