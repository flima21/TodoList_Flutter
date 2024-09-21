
import 'package:flutter/material.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage({super.key});

  // forms to get text from field
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                onChanged: onChangedEmail,
                onSubmitted: onSubmittedEmail,
              ),
              ElevatedButton(
                onPressed: login, 
                child: Text("Entrar")
              ),
            ],
          ),
        ),
      ),
    );
  }

  // get the value from textfield
  void login(){
    String text = emailController.text;
  }

  // get all the modifications in field
  void onChangedEmail(String text) {

  }

  // when click the sumbit in keyboar
  void onSubmittedEmail(String text) {

  }
}