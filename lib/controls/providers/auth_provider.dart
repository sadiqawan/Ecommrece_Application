import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:ecommrece_application/views/new_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool emailVarify = false;

  Future<void> signUp(BuildContext context, String email, String password,
      String phone, String name) async {
    try {
      isLoading = true;
      notifyListeners();
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection('user')
          .doc(userCredential.user!.uid)
          .set({
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'photo': null
      });
      Fluttertoast.showToast(
        msg: 'Successfully Registered',
        backgroundColor: Colors.green,
      );
      Navigator.of(context).pop();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: 'Registration Failed: $e',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      FirebaseAuth auth = FirebaseAuth.instance;
      emailVarify = auth.currentUser!.emailVerified;
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: 'Login Failed: ${e.message}',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void forgotPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      print('Password reset email sent to $email');
      Fluttertoast.showToast(msg: 'Password reset email sent to $email');
    } catch (error) {
      // Handle any errors that occurred during the password reset process
      print('Failed to send password reset email: $error');
      Fluttertoast.showToast(msg: 'Password reset email sent to $error');
    }
  }

// Future<void> updatePasswordInFirestore(String newPassword) async {
//   final uid = FirebaseAuth.instance.currentUser!.uid;
//   try {
//     // Get reference to the user document in Firestore
//     var userDocRef = FirebaseFirestore.instance.collection('user').doc(uid);
//
//     // Update the password field in the user document
//     await userDocRef.update({
//       'password': newPassword,
//     });
//
//     print('Password updated in Firestore for user $uid');
//   } catch (error) {
//     // Handle any errors that occurred while updating Firestore
//     print('Failed to update password in Firestore: $error');
//     throw error; // re-throwing the error for the caller to handle
//   }
// }
}
