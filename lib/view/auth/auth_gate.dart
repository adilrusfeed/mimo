import 'package:dfine_task/view/auth/login_screen.dart';
import 'package:dfine_task/view/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return user == null ?  LoginScreen() : const HomeScreen();
  }
}