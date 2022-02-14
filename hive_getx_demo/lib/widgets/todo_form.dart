import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_getx_demo/controllers/todo_controller.dart';
import 'package:hive_getx_demo/models/todo.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({
    Key? key,
    required this.type,
    this.todo
  }) : super(key: key);

  final String type;
  final Todo? todo;

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  String? description;

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();
    return Padding(
      // padding: const EdgeInsets.all(12.0),
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.todo != null ? widget.todo!.description : '',
              onSaved: (value) => description = value,
              decoration: const InputDecoration(
                hintText: "Add Description"
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                if(widget.type == "new") {
                  todoController.addTodo(Todo(description: description!));
                } else {
                  todoController.updateTodo(widget.todo!, description!);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                widget.todo != null ? "Update" : "Add",
                style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
