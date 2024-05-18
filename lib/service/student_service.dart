import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp_firebase/model/student_model.dart';

class StService {
   String imageName = DateTime.now().microsecondsSinceEpoch.toString();
  String url = "";

  CollectionReference collection =
      FirebaseFirestore.instance.collection("students");

  updateImage(imageurl, updateimage, BuildContext context) async {
    try {
      Reference editImage = FirebaseStorage.instance.refFromURL(imageurl);
      await editImage.putFile(updateimage);
      url = await editImage.getDownloadURL();
    } catch (e) {
      return [];
      
    }
    
  }
  // Future<StudentModel?> addDatas(StudentModel model) async {
  //   try {
  //     final taskMap = model.toJson();
  //     await collection.doc(model.id).set(taskMap);
  //     return model;
  //   } on FirebaseException catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }
  Future<StudentModel?> addDatas(StudentModel model) async {
    try {
      await collection.doc(model.id).set(model.toJson());
      return model;
    } catch (e) {
      print('Error: $e');
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

  File? file;
  ImagePicker image = ImagePicker();
  Future pickImage(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
  }
}
