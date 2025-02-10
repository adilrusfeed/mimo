import 'dart:developer';
// import 'dart:io';

import 'package:dfine_task/model/user_model.dart';
import 'package:dfine_task/service/firestore_service.dart';
// import 'package:dfine_task/service/permisson.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class UserController extends ChangeNotifier{
  final FirestoreService firestoreService = FirestoreService();
  //  final PermissionService permissionService = PermissionService();
  TextEditingController nameContoller = TextEditingController();

  // String? profileUrl;
  // Reference? profileImage;
  // String? profilePath;
  // File? pickedImage;
  bool isLoading = false;
  UserModel? user;
  bool isEdit = false;
  //  final ImagePicker _imagePicker = ImagePicker();

  isEditName() {
    isEdit = true;
    notifyListeners();
  }

  // Future<void> pickImage() async {
  //   await permissionService.requestPermissions();
  //   final XFile? image =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     pickedImage = File(image.path);
  //     notifyListeners();
  //   }
  // }


  // Future<void> uploadProfileImage() async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();

  //     if (pickedImage != null) {
  //       profileImage = await firestoreService.updateProfilePic(
  //         File(pickedImage!.path),
  //         imagePath: user?.profilepicPath,
  //       );

  //       if (profileImage != null) {
  //         profilePath = profileImage!.fullPath;
  //         profileUrl = await profileImage!.getDownloadURL();
  //         notifyListeners();
  //       }

  //       pickedImage = null;
  //     }

  //     isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     log(e.toString());
  //   }
  // }



   Future<void> createUser(UserModel user) async {
    try {
      isLoading = true;
      notifyListeners();

      await firestoreService.createUser(user);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error creating user: $e');
    }
  }

   Future<void> getCurrentUser() async {
    try {
      isLoading = true;
      notifyListeners();

      user = await firestoreService.getCurrentUser();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error getting user: $e');
    }
  }

  Future<void> updateUser() async {
    try {
      isLoading = true;
      isEdit = false;
      notifyListeners();
      UserModel usr = UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: user?.email ?? '',
          fullname: nameContoller.text.isEmpty
              ? user?.fullname ?? ''
              : nameContoller.text,
          // profilepicUrl: profileUrl ?? user?.profilepicUrl ?? '',
          // profilepicPath: profilePath ?? user?.profilepicPath ?? ""
          );
      await firestoreService.updateUser(usr);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error updating user: $e');
    }
  }
}