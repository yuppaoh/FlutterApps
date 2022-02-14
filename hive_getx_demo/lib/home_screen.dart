import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/todo_controller.dart';
import 'widgets/todo_form.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final todoControllerP = Get.find<TodoController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Getx Hive'),
      ),
      body: GetBuilder(
        builder: (TodoController todoController) {
          return ListView.builder(
            itemCount: todoController.todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return TodoForm(
                        type: "update",
                        todo: todoController.todos[index],
                      );
                    },
                  );
                },
                leading: Checkbox(
                  value: todoController.todos[index].isCompleted,
                  onChanged: (value) {
                    todoController.changeStatus(todoController.todos[index]);
                  },
                ),
                title: Text(
                  todoController.todos[index].description,
                ),
                trailing: IconButton(
                  onPressed: () {
                    todoController.deleteTodo(todoController.todos[index]);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) {
            return const TodoForm(
              type: "new",
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
