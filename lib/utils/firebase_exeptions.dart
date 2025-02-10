import 'package:firebase_auth/firebase_auth.dart';

String handleFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return 'The email is already in use by another account.';
    case 'weak-password':
      return 'The password provided is too weak.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'user-not-found':
      return 'No user found for that email.';
    case 'wrong-password':
      return 'Incorrect password.';
    default:
      return 'Authentication failed: ${e.message}';
  }
}
