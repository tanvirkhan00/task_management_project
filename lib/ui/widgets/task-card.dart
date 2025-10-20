import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/data/models/task_model.dart';
import 'package:task_managenent/data/services/apiCaller.dart';
import 'package:task_managenent/data/utils/urls.dart';
import 'package:task_managenent/ui/widgets/snack_bar_message.dart';

class taskCard extends StatefulWidget {
  const taskCard({super.key, required this.taskModel, required this.refreshParent});

  final TaskModel taskModel;
  final VoidCallback refreshParent;

  @override
  State<taskCard> createState() => _taskCardState();
}

class _taskCardState extends State<taskCard> {
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(widget.taskModel.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            widget.taskModel.description,
            style: TextStyle(color: Colors.grey),
          ),
          Text(widget.taskModel.createdDate),
          Row(
            children: [
              Chip(
                label: Text(widget.taskModel.status),
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Visibility(
                visible: _deleteTaskInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: IconButton(
                  onPressed: (){
                    _deleteTask();
                  } ,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ),
              Visibility(
                visible: _changeStatusInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: IconButton(
                  onPressed: _showChangeStatusDialog,
                  icon: Icon(Icons.edit, color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _changeStatus('New');
                },
                title: Text('New'),
                trailing: widget.taskModel.status == "New"
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Progress');
                },
                title: Text('Progress'),
                trailing: widget.taskModel.status == "Progress"
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Cancelled');
                },
                title: Text('Cancelled'),
                trailing: widget.taskModel.status == "Cancelled"
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Completed');
                },
                title: Text('Completed'),
                trailing: widget.taskModel.status == "Completed"
                    ? Icon(Icons.done)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _changeStatus(String status) async {
    if(status == widget.taskModel.status) {
      return ;
    }

    Navigator.pop(context);

    _changeStatusInProgress = true;
    setState(() {});

    final ApiResponse response = await apiCaller.getRequest(
      url: Urls.updateTaskStatus(widget.taskModel.id, status),);
    _changeStatusInProgress = false;
    setState(() {});
    if(response.isSuccess) {
      widget.refreshParent();
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
  }
  Future<void> _deleteTask() async {
    _deleteTaskInProgress = true;
    setState(() {});

    final ApiResponse response = await apiCaller.getRequest(
      url: Urls.deleteTask(widget.taskModel.id), );
    _deleteTaskInProgress = false;
    setState(() {});
    if(response.isSuccess) {
      widget.refreshParent();
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
  }
}
