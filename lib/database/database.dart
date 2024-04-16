import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  String boxName = "TODOLIST";

  //  init box

  final _mybox = Hive.box("todo");

  void createInitialData() {
    toDoList = [
      {"label": "Make Tutorials", "value": false},
      {"label": "Do Exercise", "value": false},
    ];
  }

  void loadData() {
    toDoList = _mybox.get(boxName);
  }

  void uodateData() {
    _mybox.put(boxName, toDoList);
  }
}
