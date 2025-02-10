import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfine_task/model/category_model.dart';
import 'package:dfine_task/model/task_model.dart';
import 'package:dfine_task/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Reference storage = FirebaseStorage.instance.ref();
  Future<void> createUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }
  Future<void> updateUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).update(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

   getCurrentUser() async {
    try {
      final user = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      return UserModel.fromJson(user.data()!);
    } catch (e) {
      rethrow;
    }
  }
   updateProfilePic(imageFile, {String? imagePath}) async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      Reference imageFolder =
          storage.child('UserProfile').child('$imageName.jpg');

      if (imagePath != null) {
        Reference image = storage.child(imagePath);
        await image.delete();
        log('The current Image Successfully deleted from Firebase Storage.');
      }
      await imageFolder.putFile(imageFile);
      log('Image successfully uploaded to Firebase Storage.');
      return imageFolder;
    } catch (e) {
      throw 'Error in Update profile pic : $e';
    }
  }

  Future<void> addCategory(CategoryModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.id)
          .set(data.toJson());
          log("data added");
    } catch (e) {
      log('Error adding category: $e');
      rethrow;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .get();
      return querySnapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching categories: $e');
      return [];
    }
  }
  

  
  Future<void> updateCategory(CategoryModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.id)
          .update(data.toJson());
    } catch (e) {
      log('Error updating category: $e');
    }
  }
  Future<void> deleteCategory(String id) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(id)
          .delete();
    } catch (e) {
      log('Error deleting category: $e');
    }
  }

/////////////////////////////////////////////////////////////////


  Future<void> addTask(TaskModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.categoryId)
          .collection('tasks')
          .doc(data.id)
          .set(data.toJson());
    } catch (e) {
      log('Error adding task: $e');
      rethrow;
    }
  }

  Future<List<TaskModel>> getAllTasks(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(categoryId)
          .collection('tasks')
          .orderBy('date', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching tasks: $e');
      return [];
    }
  }

  Future<void> updateTask(TaskModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.categoryId)
          .collection('tasks')
          .doc(data.id)
          .update({"isComplete": data.isComplete});
    } catch (e) {
      log('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String categoryId, String id) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(categoryId)
          .collection('tasks')
          .doc(id)
          .delete();
    } catch (e) {
      log('Error deleting task: $e');
    }
  }

}