import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist_new/dialogbox.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});
  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  void initState() {
    super.initState();
    if (_myBox.isNotEmpty) {
      todo = List.from(_myBox.values);
    }
  }

  List<dynamic> todo = [
    ["gaming", false],
  ];
  final _controller = TextEditingController();
  final String taskName = '';
  final bool taskCompleted = false;
  Function(bool?)? onChange;
  Function(BuildContext)? delteFunc;
  final _myBox = Hive.box('mybox');
  void deleteFunc(int index) {
    setState(() {
      _myBox.delete(todo[index]);
      todo.removeAt(index);
    });
  }

  void saveNewTask() {
    setState(() {
      todo.add([_controller.text, false]);
      _myBox.put(todo.length - 1, [_controller.text, false]);

      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          onSave: saveNewTask,
          onCancle: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'To do List',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todo.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => deleteFunc(index),
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Card(
                color: const Color.fromARGB(250, 236, 172, 54),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: todo[index][1],
                        onChanged: (bool? newvalue) {
                          setState(() {
                            todo[index][1] = newvalue!;
                          });
                        },
                      ),
                      Text(
                        todo[index][0],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
