import 'package:flutter/material.dart';
import 'package:studentapp_firebase/model/student_model.dart';
import 'package:studentapp_firebase/service/student_service.dart';

class ServiceController extends ChangeNotifier {
  StService service = StService();
  Future<void> addStudent(StudentModel model) async {
    await service.addDatas(model);
    notifyListeners();
  }
}
