import 'package:dfine_task/model/user_model.dart';
import 'package:dfine_task/service/auth_service.dart';
import 'package:dfine_task/utils/firebase_exeptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier{
  final AuthService authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  bool isLoading = false;

  Future<String?> registerUser() async {
    isLoading = true;
    notifyListeners();

    UserModel userModel = UserModel(
      email: emailController.text,
      password: passwordController.text,
      fullname: fullNameController.text,
    );

    var result = await authService.registerUser(userModel);

    isLoading = false;
    notifyListeners();

    if (result is FirebaseAuthException) {
      return handleFirebaseAuthException(result);
    }

    return null;
  }

  Future<String?> loginUser() async {
    isLoading = true;
    notifyListeners();

    var result = await authService.loginUser(
      emailController.text,
      passwordController.text,
    );

    isLoading = false;
    notifyListeners();

    if (result is FirebaseAuthException) {
      return handleFirebaseAuthException(result);
    }

    return null;
  }

  Future<String?> logoutUser() async {
    isLoading = true;
    notifyListeners();

    try {
      await authService.logoutUser();
      isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return "Logout Error: $e";
    }
  }

  Future<String?> forgotPassword() async {
    isLoading = true;
    notifyListeners();

    var result = await authService.sendPasswordResetEmail(emailController.text);

    isLoading = false;
    notifyListeners();

    if (result is FirebaseAuthException) {
      return handleFirebaseAuthException(result);
    }

    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}