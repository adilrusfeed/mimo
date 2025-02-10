import 'package:dfine_task/controller/auth_controller.dart';
import 'package:dfine_task/controller/category_controller.dart';
import 'package:dfine_task/controller/task_controller.dart';
import 'package:dfine_task/controller/theme_controller.dart';
import 'package:dfine_task/controller/user_controller.dart';
import 'package:dfine_task/utils/firebase_options.dart';
import 'package:dfine_task/view/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController(),),
         ChangeNotifierProvider(create: (context) => UserController()),
         ChangeNotifierProvider(create: (context) => TaskController()),
         ChangeNotifierProvider(create: (context) => CategoryController()),
          ChangeNotifierProvider(create: (context) => ThemeController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:AuthGate()
      ),
    );
  }
}