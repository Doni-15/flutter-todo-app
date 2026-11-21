import 'package:belajar_firebase_auth/models/todo.dart';
import 'package:belajar_firebase_auth/services/firestore_services.dart';
import 'package:belajar_firebase_auth/widgets/todo_dialog.dart';
import 'package:belajar_firebase_auth/widgets/todo_item.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  final FirestoreServices _firestoreServices = FirestoreServices();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo list')),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context) => TodoDialog(firestoreServices: _firestoreServices)
          );
        },

        child: const Icon(Icons.add),
      ),

      body: StreamBuilder<List<Todo>>(
        stream: _firestoreServices.getTodos(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada tugas'));
          }

          final todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index){
              return TodoItem(
                todo: todos[index], 
                firestoreServices: _firestoreServices
              );
            },
          );
        },
      ),
    );
  }
}