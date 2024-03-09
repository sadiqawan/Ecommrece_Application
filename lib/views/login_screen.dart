import 'package:ecommrece_application/controls/providers/auth_provider.dart';
import 'package:ecommrece_application/views/home_screen.dart';
import 'package:ecommrece_application/views/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../modes/custom_wedgits/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailC, passwordC;

  @override
  void initState() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailC?.dispose();
    passwordC?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(70),
              TextField(
                controller: emailC,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder()),
              ),
              const Gap(16),
              TextField(
                obscureText: true,
                controller: passwordC,
                decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock_open_rounded),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye)),
                    border: const OutlineInputBorder()),
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: Consumer<LoginProvider>(
                      builder: (BuildContext context, LoginProvider value,
                          Widget? child) {
                        return CustomButton(
                            text: 'Login',
                            backgroundColor: Colors.black,
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            onTap: () {
                              context.read<LoginProvider>().logIn(
                                  emailC!.text.trim(), passwordC!.text.trim());
                              value.emailVarify
                                  ? Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()))
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VerificationScreen()));
                              if (value.isLoading) {
                                Container(
                                  color: Colors.white.withOpacity(0.5),
                                  // Semi-transparent background
                                  child: const Center(
                                    child: SpinKitWave(color: Colors.black),
                                  ),
                                );
                              }
                            });
                      },
                    ),
                  ),
                ],
              ),
              const Gap(16),
              TextButton(
                  onPressed: () {}, child: const Text('Forgot Password ? ')),
              const Gap(16),
              TextButton(
                  onPressed: () {},
                  child: const Text('Do not have account? SingUp!  ')),
              Image.asset('images/icon_image.jpg')
            ],
          ),
        ),
      ),
    );
  }
}
