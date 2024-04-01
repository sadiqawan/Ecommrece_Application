import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool emailVarify = false;


  Future<void> signUp(String email, String password, String phone, String name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection('user').doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'password': password.trim(),
        'photo': null
      });

      Fluttertoast.showToast(
        msg: 'Successfully Registered',
        backgroundColor: Colors.green,
      );
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
      FirebaseAuth auth = FirebaseAuth.instance;
       emailVarify =  auth.currentUser!.emailVerified ;
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

  void logOut (){
    FirebaseAuth.instance.signOut();
  }

  void forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      print('Password reset email sent to $email');
    } catch (error) {
      // Handle any errors that occurred during the password reset process
      print('Failed to send password reset email: $error');
    }
  }

}
