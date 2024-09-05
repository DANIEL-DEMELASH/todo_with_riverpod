import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_with_riverpod/models/todo.dart';
import 'package:todo_with_riverpod/riverpod/todo_riverpod.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoRiverpod).todos;
    
    final textController = TextEditingController();
    
    showNewTodoDialog(BuildContext context){
      return showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text('New Todo'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('cancel')),
            TextButton(onPressed: () {
              ref.read(todoRiverpod).addTodo(TodoModel(id: DateTime.now().microsecondsSinceEpoch, text: textController.text));
              Navigator.pop(context);
            }, child: const Text('add')),
          ],
        ));
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo with riverpod'),
        centerTitle: true,
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewTodoDialog(context),
        backgroundColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.add),
        ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15), 
        child: ListView.separated(
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                value: todo.isCompleted, 
                onChanged: (bool? newValue){
                  ref.read(todoRiverpod).toggleTodo(todo);
                }),
              
              title: Text(todo.text),
              
              trailing: IconButton(
                onPressed: () {
                  ref.read(todoRiverpod).removeTodo(todo);
                }, icon: const Icon(Icons.cancel_outlined)),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 4);
          },
          itemCount: ref.watch(todoRiverpod).todos.length),),
    );
  }
}