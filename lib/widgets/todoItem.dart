import 'dart:ui';

import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.onDelete,
    required this.onSetComplete,
  });

  final String title;
  final String description;
  final bool isComplete;
  final Function() onDelete;
  final Function(bool) onSetComplete;

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Checkbox(value: isComplete, onChanged: (status) {if (status!=null) onSetComplete(status);},),
          ),
          Expanded(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Text(description, style: TextStyle(fontSize: 14), softWrap: true,),
              ],
            ),
          ),
          IconButton(onPressed: onDelete , icon: const Icon(Icons.delete))
        ],
      ),
    ));
  }
}