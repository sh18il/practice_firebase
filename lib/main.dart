import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_firebase/controller/service_controller.dart';
import 'package:studentapp_firebase/firebase_options.dart';
import 'package:studentapp_firebase/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
    );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>ServiceController() ,),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
