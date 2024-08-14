import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/Task_Model.dart';

class FireBaseService {
  static CollectionReference<TaskModel> _getCollection() =>
      FirebaseFirestore.instance
          .collection('tasksCollection')
          .withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.fromjson(docSnapshot.data()!),
            toFirestore: (taskmodel, _) => taskmodel.tojson(),
          );

  static Future<void> addtask(TaskModel task) async {
    CollectionReference<TaskModel> taskscollection = _getCollection();
    DocumentReference<TaskModel> docref = taskscollection.doc();
    task.id = docref.id;
    return docref.set(task);
  }

  static Future<void> deletetask(String id) async {
    CollectionReference<TaskModel> taskcollection = _getCollection();
    return taskcollection.doc(id).delete();
  }

  static Future<List<TaskModel>> gettasks() async {
    CollectionReference<TaskModel> taskcollection = _getCollection();
    QuerySnapshot<TaskModel> querySnapshot = await taskcollection.get();
    return querySnapshot.docs.map((docsanpshot) => docsanpshot.data()).toList();
  }
}
