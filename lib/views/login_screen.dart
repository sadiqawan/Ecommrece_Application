import 'package:ecommrece_application/controls/providers/auth_provider.dart';
import 'package:ecommrece_application/views/forgot_password_screen.dart';
import 'package:ecommrece_application/views/home_screen.dart';
import 'package:ecommrece_application/views/signup_screen.dart';
import 'package:ecommrece_application/views/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailC, passwordC;
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(70),
                TextFormField(
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
                const Gap(16),
                TextFormField(
                  obscureText: true,
                  controller: passwordC,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
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
                          return InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginProvider>().logIn(
                                    emailC!.text.trim(), passwordC!.text.trim());
                                if (value.emailVarify) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const HomeScreen()));
                                } else {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const VerificationScreen()));
                                }
                              }
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: (context
                                    .watch<LoginProvider>()
                                    .isLoading)
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen()));
                  },
                  child: const Text('Forgot Password ? '),
                ),
                const Gap(16),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                    },
                    child: const Text('Do not have account? SingUp!  ')),
                Image.asset('images/icon_image.jpg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
