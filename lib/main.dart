import 'package:flutter/material.dart';
import 'package:to_do_list/pages/to_do_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false, // remove tag mode debug
      theme: ThemeData.dark(),
      home: ToDoListPage(),
    );
  }
}