import 'package:flutter/material.dart';
import 'package:task_managenent/data/models/task_status_count_model.dart';
import '../../data/services/apiCaller.dart';
import '../../data/utils/urls.dart';

class TaskCountProvider extends ChangeNotifier {
  bool _getStatusCountInProgress = false;
  String? _errorMessage;

  List<TaskStatusCountModel> _taskStatusCountList = [];

  bool get getStatusCountInProgress => _getStatusCountInProgress;
  String? get errorMessage => _errorMessage;

  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

  Future<bool> getTaskCount() async {
    bool isSuccess = false;

    _getStatusCountInProgress = true;
    notifyListeners();

    final ApiResponse response = await apiCaller.getRequest(
      url: Urls.statusCount,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getStatusCountInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
