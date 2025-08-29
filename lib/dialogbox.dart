import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_new/my_button.dart';

class Dialogbox extends StatefulWidget {
  final _myBox = Hive.box('mybox');
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancle;
  Dialogbox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancle,
  });

  @override
  State<Dialogbox> createState() => _DialogboxState();
}

class _DialogboxState extends State<Dialogbox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber,
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(hintText: "Add new Task"),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  MyButton(text: 'Add', onPressed: widget.onSave),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: MyButton(text: 'Cancle', onPressed: widget.onCancle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
