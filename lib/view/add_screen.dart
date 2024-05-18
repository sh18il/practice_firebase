import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:studentapp_firebase/controller/service_controller.dart';
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
    StService service = StService();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      service.file != null ? FileImage(service.file!) : null,
                  child: service.file == null
                      ? Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.grey,
                        )
                      : null,
                ),
                TextButton(
                    onPressed: () {
                      StService().pickImage(ImageSource.gallery);
                    },
                    child: Text("pick image")),
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
    final pro = Provider.of<ServiceController>(context, listen: false);
    String id = randomAlphaNumeric(10);
    StudentModel stModel = StudentModel(
        name: nameCtrl.text,
        email: emailCtrl.text,
        address: addresCtrl.text,
        id: id);

    await StService().addDatas(stModel);
  }
}
