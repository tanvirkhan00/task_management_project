import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/services/apiCaller.dart';
import '../../data/utils/urls.dart';

class NewTaskListProvider extends ChangeNotifier {
  bool _getNewTaskInProgress = false;
  String? _errorMessage;

  List<TaskModel> _newTaskList = [];

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  String? get errorMessage => _errorMessage;

  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTasks() async {
    bool isSuccess = false;

    _getNewTaskInProgress = true;
    notifyListeners();

    final ApiResponse response = await apiCaller.getRequest(
      url: Urls.newTaskListUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getNewTaskInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
