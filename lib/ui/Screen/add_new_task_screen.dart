import 'package:flutter/material.dart';
import 'package:task_managenent/ui/widgets/screen_background.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: 32,),
                   Text('Add New Task', style: Theme.of(context).textTheme.titleLarge,),
                   SizedBox(height: 16,),
                   TextFormField(
                     controller: _TEController,
                     textInputAction: TextInputAction.next,
                     decoration: InputDecoration(
                       hintText: 'Title'
                     ),
                   ),
                   SizedBox(height: 8,),
                   TextFormField(
                     controller: _DEController,
                     textInputAction: TextInputAction.next,
                     decoration: InputDecoration(
                       hintText: 'Description'
                     ),
                     maxLines: 6,
                   ),
                   SizedBox(height: 16,),
                   FilledButton(onPressed: (){}, child: Text('Add'))
                 ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
