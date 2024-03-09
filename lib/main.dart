import 'package:ecommrece_application/views/login_screen.dart';
import 'package:ecommrece_application/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBQRKdqFL_LkvESSCvsZA-eWQ3IMwXXZe0',
          appId: '1:675125432554:android:0fae5953b493274d474793',
          messagingSenderId: '675125432554',
          projectId: 'ecommerecapp-d3828',
          storageBucket: 'ecommerecapp-d3828.appspot.com'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bagzz',
      theme: ThemeData(
        fontFamily: GoogleFonts.playfairDisplay.toString(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
