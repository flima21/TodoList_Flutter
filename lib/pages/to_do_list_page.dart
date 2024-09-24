import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<String> tasks = [];

  // controllers
  final TextEditingController tasksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TO DO LIST",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                    controller: tasksController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your task',
                      hintText: 'Example: study flutter',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        tasks.add(value);
                        tasksController.clear();
                      });
                    },
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          tasks.add(tasksController.text);
                          tasksController.clear();
                        });
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(15)),
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.blue),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      )),
                      
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Flexible(
                child: ListView(
                  children: [
                    for (String task in tasks)
                      ListTile(
                        title: Text(task),
                        subtitle: Text(''),
                        leading: Icon(Icons.task),
                        onTap: () => {
                          print('Task: $task')
                        },
                      )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text("You have a 0 pendents task")),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tasks.clear();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.red),
                    ),
                    child: Text("Clear"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
