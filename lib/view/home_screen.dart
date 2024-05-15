import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentapp_firebase/model/student_model.dart';
import 'package:studentapp_firebase/service/student_service.dart';
import 'package:studentapp_firebase/view/add_screen.dart';
import 'package:studentapp_firebase/view/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final delailStem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddScreen(),
        ));
      }),
      body: StreamBuilder<List<StudentModel>>(
        stream: StService().getAllData(),
        builder: (context, AsyncSnapshot<List<StudentModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("error code${snapshot.error}"),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                StudentModel data = snapshot.data![index];
                return ListTile(
                  title: Text(data.name.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            StService().deleteData(data.id!);
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditScreen(
                                  name: data.name.toString(),
                                  email: data.email.toString(),
                                  addres: data.address.toString(),
                                  id: data.id!),
                            ));
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: Text("no data"),
          );
        },
      ),
    );
  }
}
