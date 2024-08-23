import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/Task_Model.dart';
import 'package:todo_app/models/User_Model.dart';

class FireBaseService {
  static CollectionReference<UserModel> _getusercollection() =>
      FirebaseFirestore.instance
          .collection('userCollection')
          .withConverter<UserModel>(
              fromFirestore: (docsnapshot, _) =>
                  UserModel.fromjson(docsnapshot.data()!),
              toFirestore: (user, _) => user.tojson());

  static CollectionReference<TaskModel> _getCollection(String userid) =>
      _getusercollection()
          .doc(userid)
          .collection('tasksCollection')
          .withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.fromjson(docSnapshot.data()!),
            toFirestore: (taskmodel, _) => taskmodel.tojson(),
          );

  static Future<void> addtask(TaskModel task, String userid) async {
    CollectionReference<TaskModel> taskscollection = _getCollection(userid);
    DocumentReference<TaskModel> docref = taskscollection.doc();
    task.id = docref.id;
    return docref.set(task);
  }

  static Future<void> deletetask(String id, String userid) async {
    CollectionReference<TaskModel> taskcollection = _getCollection(userid);
    return taskcollection.doc(id).delete();
  }

  static Future<List<TaskModel>> gettasks(String userid) async {
    CollectionReference<TaskModel> taskcollection = _getCollection(userid);
    QuerySnapshot<TaskModel> querySnapshot = await taskcollection.get();
    return querySnapshot.docs.map((docsanpshot) => docsanpshot.data()).toList();
  }

  static Future<void> edittask(
      String id, Map<String, dynamic> data, String userid) async {
    CollectionReference<TaskModel> taskcollections = _getCollection(userid);
    DocumentReference<TaskModel> docref = taskcollections.doc(id);
    return await docref.update(data);
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credentials =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModel(name: name, email: email, id: credentials.user!.uid);
    final usercollection = _getusercollection();
    await usercollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final usercollection = _getusercollection();
    final docsnapshot = await usercollection.doc(credentials.user!.uid).get();
    return docsnapshot.data()!;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
