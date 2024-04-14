import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../controls/providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController? emailC;

  @override
  void initState() {
    emailC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailC?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgotPassword'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            const Text(
              'Please provide your email!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                try {
                  String? email = emailC?.text.trim();
                  if (email == null || email.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Failed to send: Email is empty',
                      backgroundColor: Colors.red,
                    );
                  } else {
                    context
                        .read<LoginProvider>()
                        .forgotPassword(context, emailC!.text.trim());
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e.toString());
                  Fluttertoast.showToast(
                      msg: e.toString(), backgroundColor: Colors.red);
                }
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text(
                    'Sand',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
