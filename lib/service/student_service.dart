import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentapp_firebase/model/student_model.dart';

class StService {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("students");
  Future<StudentModel?> addDatas(StudentModel model) async {
    try {
      final taskMap = model.toJson();
      await collection.doc(model.id).set(taskMap);
      return model;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Future<Stream<List<StudentModel>>> getAllData() async {
  //   try {
  //     return collection.snapshots().map((QuerySnapshot snapshot) {
  //       return snapshot.docs.map((DocumentSnapshot doc) {
  //         return StudentModel.fromJson(doc.data() as Map<String, dynamic>);
  //       }).toList();
  //     });
  //   } on FirebaseException catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }
  Stream<List<StudentModel>> getAllData() {
    return collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => StudentModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future deleteData(String id) async {
    return await collection.doc(id).delete();
  }

  Future updateData(StudentModel model) async {
    return await collection.doc(model.id).update(model.toJson());
  }
}
