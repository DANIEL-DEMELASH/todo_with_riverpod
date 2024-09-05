import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_with_riverpod/models/todo.dart';

final todoRiverpod = ChangeNotifierProvider<Todo>((ref) {
  return Todo();
});