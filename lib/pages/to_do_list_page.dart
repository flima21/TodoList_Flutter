import 'package:flutter/material.dart';
import 'package:to_do_list/models/Task.dart';
import 'package:to_do_list/repository/task_repository.dart';
import 'package:to_do_list/widgets/to_do_list_item.dart';

class ToDoListPage extends StatefulWidget {
  ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Task> tasks = [];

  int? deletedTodoPos;
  bool isEmpty = false;

  // controllers
  final TextEditingController tasksController = TextEditingController();
  final TaskRepository taskRepository = TaskRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); // 
    taskRepository.getAll().then((value) => 
      setState(() {
        tasks = value;
      })
    );
  }

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
                      errorText: isEmpty ? 'Required' : null,
                      border: OutlineInputBorder(),
                      labelText: 'Enter your task',
                      hintText: 'Example: study flutter',
                    ),
                    onSubmitted: (value) {
                      onStore();
                    },
                    onChanged: (value) {
                      setState(() {
                        isEmpty = value.isEmpty;
                      });
                    },
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: onStore,
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
                    for (Task task in tasks)
                      ToDoListItem(
                        task: task,
                        onDelete: onDelete,
                      )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("You have a ${tasks.length} pendents task")),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: onDialogDelete,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.red),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          Text("Clear"),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onDialogDelete() {
    if (tasks.length > 0) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.delete), 
            Text("Attention!")
          ]
        ),
        content: Text("Are you sure you want to delete all tasks?"),
        actions: [
          TextButton(
            onPressed: onDeleteAll, 
            child: Text("Yes",style: TextStyle(color: Colors.blue),)
          ),
          TextButton(
            onPressed: () { Navigator.of(context).pop(); }, 
            child: Text("No",style: TextStyle(color: Colors.blue),)
          ),
        ],
      ));
    }

    else {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.delete), 
            Text("Attention!")
          ]
        ),
        content: Text("You do not have task to delete!"),
        actions: [
          TextButton(child: Text("Cancel"),onPressed: () { Navigator.of(context).pop(); },)
        ],
      ));
    }
  }

  void onDeleteAll() {
    setState(() {
      tasks.clear();
      Navigator.of(context).pop();
    });

    taskRepository.storeListTasks(tasks);
  }

  void onDelete(Task task) {
    deletedTodoPos = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
    });

    taskRepository.storeListTasks(tasks);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task ${task.title} removed sucessefuly!', style: TextStyle(color: Colors.white),),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.grey.shade900,
        action: SnackBarAction(label: "Undo", textColor: Colors.blue, onPressed: () {
          setState(() {
            tasks.insert(deletedTodoPos!,task);
          });
          taskRepository.storeListTasks(tasks);
        }),
      ),
    );

  }

  void onStore() {
    setState(() {
      if (tasksController.text.isEmpty) {
        isEmpty = true;
      } else {
        tasks.add(Task(title: tasksController.text, dateTime: DateTime.now()));
        tasksController.clear();
        isEmpty = false;
        taskRepository.storeListTasks(tasks);
      }
    });
  }
}
