import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database/database.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // box reference
  // text controller
  final TextEditingController _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();
  final _myBox = Hive.box("todo");
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index]["value"] = !db.toDoList[index]["value"];
    });
    db.uodateData();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add({"label": _controller.text, "value": false});
    });
    db.uodateData();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: saveNewTask,
          );
        });
  }

  void deleteTask(index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    db.uodateData();
  }

  @override
  void initState() {
    // TODO: implement initState

    // if this is the first time running the app ever add default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Text("To Do"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) => ToDoTile(
          taskName: db.toDoList[index]["label"],
          taskCompleted: db.toDoList[index]["value"],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
        ),
      ),
    );
  }
}
