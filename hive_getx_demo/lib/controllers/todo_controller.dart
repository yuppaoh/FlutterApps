import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_getx_demo/models/todo.dart';

class TodoController extends GetxController {
  late List<Todo> _todos;
  late Box<Todo> todoBox;
  List<Todo> get todos => _todos;
  
  TodoController() {
    todoBox = Hive.box<Todo>('todos');
    _todos = [];

    for(int i = 0; i < todoBox.values.length; i++) {
      _todos.add(todoBox.getAt(i)!);
    }
  }
  
  addTodo(Todo todo) {
    _todos.add(todo);
    todoBox.add(todo);
    update();
  }
  
  deleteTodo(Todo todo) {
    int index = _todos.indexOf(todo);
    todoBox.deleteAt(index);
    _todos.removeWhere((element) => element.id == todo.id);
    update();
  }

  changeStatus(Todo todo) {
    int index = _todos.indexOf(todo);
    _todos[index].isCompleted = !_todos[index].isCompleted;
    // todoBox.putAt(index, _todos[index]);
    _todos[index].save();   // we can use save() as we have extended our model with hive object.
    update();
  }

  updateTodo(Todo oldTodo, String newDescription) {
    int index = _todos.indexOf(oldTodo);
    _todos[index].description = newDescription;
    // todoBox.putAt(index, _todos[index]);
    _todos[index].save();   // we can use save() as we have extended our model with hive object.
    update();
  }

}