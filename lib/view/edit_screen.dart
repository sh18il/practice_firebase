import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:studentapp_firebase/model/student_model.dart';
import 'package:studentapp_firebase/service/student_service.dart';

class EditScreen extends StatelessWidget {
  final String name;
  final String email;
  final String addres;
  final String id;
  EditScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.addres,
      required this.id});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameCtrl = TextEditingController(text: name);
    TextEditingController emailCtrl = TextEditingController(text: email);
    TextEditingController addresCtrl = TextEditingController(text: addres);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Gap(15),
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(
                label: Text("name"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Gap(15),
            TextFormField(
              controller: emailCtrl,
              decoration: InputDecoration(
                label: Text("email"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Gap(15),
            TextFormField(
              controller: addresCtrl,
              decoration: InputDecoration(
                label: Text("address"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Gap(15),
            ElevatedButton(
                onPressed: () {
                  StudentModel upModel = StudentModel(
                      address: addresCtrl.text,
                      email: emailCtrl.text,
                      name: nameCtrl.text,
                      id: id);
                  StService()
                      .updateData(upModel)
                      .then((value) => Navigator.pop(context));
                },
                child: Text("submit")),
          ],
        ),
      ),
    );
  }
}
