import 'package:belajar_firebase_auth/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference _todosCollection = FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(String taskName) async{
    final newTodo = Todo(
      id: '', 
      task: taskName, 
      isDone: false
    );

    await _todosCollection.add(newTodo.toMap());
  }

  // Mengambil todo dari firestore
  Stream<List<Todo>> getTodos() {
    return _todosCollection
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
          .map((doc) => Todo.fromFirestore(doc))
          .toList(),
      )
    ;
  }

  // Update status todo
  Future<void> updateTodoStatus(String id, bool currentStatus) async{
    await _todosCollection.doc(id).update({'isDone': !currentStatus});
  }

  // Delete todo
  Future<void> deleteTodo(String id) async{
    await _todosCollection.doc(id).delete();
  }
}