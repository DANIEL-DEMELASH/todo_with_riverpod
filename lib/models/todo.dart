import 'package:flutter/material.dart';

class Todo extends ChangeNotifier {
  List<TodoModel> todos = [];
  
  void addTodo(TodoModel todo){
    todos.add(todo);
    notifyListeners();
  }
  
  void removeTodo(TodoModel todo){
    todos.remove(todo);
    notifyListeners();
  }
  
  void toggleTodo(TodoModel todo){
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
  }
}

class TodoModel {
  int id;
  String text;
  bool isCompleted;
  
  TodoModel({
    required this.id,
    required this.text,
    this.isCompleted = false
  });
}