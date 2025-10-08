import 'package:flutter/material.dart';
import 'package:task_managenent/data/services/apiCaller.dart';
import 'package:task_managenent/data/utils/urls.dart';
import 'package:task_managenent/ui/widgets/screen_background.dart';
import 'package:task_managenent/ui/widgets/snack_bar_message.dart';
import 'package:task_managenent/ui/widgets/tm_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _TEController = TextEditingController();
  final TextEditingController _DEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _TEController,

                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Title'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Title";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _DEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Description";
                      }
                      return null;
                    },
                    maxLines: 6,
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: _ontapAddButton,
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _ontapAddButton() {
    if (_formKey.currentState!.validate()) ;
    _addNewTask();
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _TEController.text.trim(),
      "description": _DEController.text.trim(),
      "status": "New",
    };

    final ApiResponse response = await apiCaller.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );

    if (response.isSuccess) {
      _clearFields();
      showSnakbarMessage(context, "New Task Added");
    } else {
      showSnakbarMessage(context, response.errorMessage!);
    }
  }

  void _clearFields() {
    _TEController.clear();
    _DEController.clear();
  }
}
