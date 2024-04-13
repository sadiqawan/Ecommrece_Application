import 'package:ecommrece_application/controls/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? emailC, passwordC, nameC, phoneC;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameC = TextEditingController();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    phoneC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC?.dispose();
    phoneC?.dispose();
    emailC?.dispose();
    passwordC?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
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
                const Gap(30),
                TextFormField(
                  controller: nameC,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
                const Gap(16),
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
                      prefixIcon: Icon(Icons.alternate_email),
                      border: OutlineInputBorder()),
                ),
                const Gap(16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneC,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Phone No',
                      prefixIcon: Icon(Icons.phone_android),
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
                                context.read<LoginProvider>().signUp(
                                  context,
                                  emailC!.text.trim(),
                                  passwordC!.text.trim(),
                                  phoneC!.text.trim(),
                                  nameC!.text.trim(),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Enter the Required fields',
                                    backgroundColor: Colors.red);
                              }
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: (context.watch<LoginProvider>().isLoading)
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : const Text(
                                  'Register',
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
                const Gap(10),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Already have an account? Login!')),
                Image.asset('images/icon_image.jpg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
