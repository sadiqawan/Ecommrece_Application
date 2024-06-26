import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommrece_application/views/signup_screen.dart';

// import 'package:ecommrece_application/views/new_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../views/home_screen.dart';
import '../../views/verification_screen.dart';

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

  Future<void> logIn(String email, String password, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      FirebaseAuth auth = FirebaseAuth.instance;
      // Check if currentUser is not null before accessing its properties
      if (auth.currentUser != null) {
        emailVarify = auth.currentUser!.emailVerified;
      }
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (emailVarify = true) {
          Navigator.push(context, PageTransition(
              type: PageTransitionType.leftToRight,
              duration: const Duration(milliseconds: 1300), child: const HomeScreen()));
        //
        //   // Navigator.of(context).pushReplacement(
        //   //     MaterialPageRoute(
        //   //         builder: (context) =>
        //   //         const HomeScreen()));
        } else {
          Navigator.push(context, PageTransition(
              type: PageTransitionType.leftToRight, duration: const Duration(milliseconds: 1300), child: const VerificationScreen()));

        //   // Navigator.of(context).push(
        //   //     MaterialPageRoute(
        //   //         builder: (context) =>
        //   //         const VerificationScreen()));
        }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'User not found. Please create an account.',
          backgroundColor: Colors.red,
        );
        // Navigate to the signup screen
        Navigator.push(context, PageTransition(
            type: PageTransitionType.leftToRight, duration: const Duration(seconds: 1), child: const SignUpScreen()));
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const SignUpScreen(),
        //   ),
        // );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Incorrect password. Please try again.',
          backgroundColor: Colors.red,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Login Failed: ${e.message}',
          backgroundColor: Colors.red,
        );
      }
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
