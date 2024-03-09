import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';

import 'home_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool emailVerified = false;
  Timer? timer;

  void initState() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      verificationCheck();
    });

    super.initState();
  }

  verificationCheck() {
    FirebaseAuth.instance.currentUser!.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      timer!.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verification Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verify Your email!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            Text(
                'Email has been sand on ${FirebaseAuth.instance.currentUser!.email}'),
            const Gap(20),
            const SpinKitWave(color: Colors.black),
            const Gap(20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                    });
                  },
                  child: const Text(
                    'Resend',
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
