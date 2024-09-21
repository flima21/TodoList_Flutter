import 'package:flutter/material.dart';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({super.key});

  // bool get erroTask => 
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: 'New Task',
                ),
                keyboardType: TextInputType.text,
                autofocus: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}