import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/Task.dart';

const variableShareTaskList = 'sp_list_task';

class TaskRepository {
  // tell to dart that will be use after
  late SharedPreferences sharedPreferences;

  // functions 
  Future<List<Task>> getAll() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // sotre in variable
    final String jsonString = sharedPreferences.getString(variableShareTaskList) ?? '[]';
    // decode string to json
    final List decode = json.decode(jsonString) as List;

    return decode.map((e) => Task.fromJson(e)).toList();
  }

  void example() {
    sharedPreferences.setString('sp_name', 'Felipe');
  }

  void storeListTasks(List<Task> tasks) {
    sharedPreferences.setString(variableShareTaskList, json.encode(tasks));
  }
}