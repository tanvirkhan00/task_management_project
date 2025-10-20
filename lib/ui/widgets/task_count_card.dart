import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TCStatusCard extends StatefulWidget {
  const TCStatusCard({
    super.key, required this.title, required this.count,
  });

  final String title;
  final int count;

  @override
  State<TCStatusCard> createState() => _TCStatusCardState();
}

class _TCStatusCardState extends State<TCStatusCard> {


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
        child: Column(
          children: [
            Text('${widget.count}', style: Theme.of(context).textTheme.titleLarge,),
            Text('${widget.title}', style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}
