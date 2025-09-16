import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class taskCard extends StatelessWidget {
  const taskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            title: Text('Tanvir Khan'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text('Describe Your Data', style: TextStyle(color: Colors.grey),),
                Text('15-09-2025'),
                Row(
                  children: [
                    Chip(
                      label: Text('New'),
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
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
      ),
    );
  }
}
