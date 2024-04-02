import 'package:ecommrece_application/controls/providers/admin_provider.dart';
import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:ecommrece_application/controls/providers/favourite_provider.dart';
import 'package:ecommrece_application/controls/providers/search_provider.dart';
import 'package:ecommrece_application/views/login_screen.dart';
import 'package:ecommrece_application/views/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ecommrece_application/controls/providers/auth_provider.dart';

import 'controls/providers/shopping_card_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CustomerHomeProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingCardProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bagzz',
        theme: ThemeData(
          fontFamily: GoogleFonts.playfairDisplay.toString(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                    child: SpinKitSpinningLines(
                  color: Colors.black,
                  size: 80,
                )),
              );
            }
            final user = snapshot.data;
            if (user != null && user.emailVerified) {
              return const SplashScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
