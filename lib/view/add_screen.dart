import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:random_string/random_string.dart';
import 'package:studentapp_firebase/model/student_model.dart';
import 'package:studentapp_firebase/service/student_service.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController addresCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Gap(15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    label: Text("name"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Gap(15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: emailCtrl,
                  decoration: InputDecoration(
                    label: Text("email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Gap(15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  controller: addresCtrl,
                  decoration: InputDecoration(
                    label: Text("address"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Gap(15),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                          addData(context);
                      Navigator.pop(context);
                      }
                    
                    },
                    child: Text("submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addData(BuildContext context) async {
    String id = randomAlphaNumeric(10);
    StudentModel stModel = StudentModel(
        name: nameCtrl.text,
        email: emailCtrl.text,
        address: addresCtrl.text,
        id: id);

    await StService().addDatas(stModel);
  }
}
