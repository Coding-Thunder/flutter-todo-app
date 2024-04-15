import 'package:flutter/material.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final TextEditingController _controller = TextEditingController();
  List toDoList = [
    {"label": "Make Tutorials", "value": false},
    {"label": "Do Exercise", "value": false},
    {"label": "Take a Shit", "value": true},
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index]["value"] = !toDoList[index]["value"];
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add({"label": _controller.text, "value": false});
    });
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
      toDoList.removeAt(index);
    });
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
        itemCount: toDoList.length,
        itemBuilder: (context, index) => ToDoTile(
          taskName: toDoList[index]["label"],
          taskCompleted: toDoList[index]["value"],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
        ),
      ),
    );
  }
}
