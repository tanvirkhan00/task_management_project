import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managenent/data/models/task_model.dart';

class taskCard extends StatelessWidget {
  const taskCard({super.key, required this.taskModel,});

  final TaskModel taskModel ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      title: Text(taskModel.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(taskModel.description, style: TextStyle(color: Colors.grey),),
          Text(taskModel.createdDate),
          Row(
            children: [
              Chip(
                label: Text(taskModel.status),
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(
                    color: Colors.white
                ),
              ),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.blue,))
            ],
          )
        ],
      ),

    );
  }
}
