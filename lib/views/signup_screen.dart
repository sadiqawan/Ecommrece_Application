import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../modes/custom_wedgits/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? emailC, passwordC, nameC;

  @override
  void initState() {
    nameC = TextEditingController();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC?.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(70),
              
              TextField(
                controller: nameC,
                decoration: const InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder()),
              ),
              const Gap(16),
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
                        onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                    border: const OutlineInputBorder()),
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                          text: 'Register',
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          onTap: () {})),
                ],
              ),
              const Gap(16),
              TextButton(
                  onPressed: () {},
                  child: const Text('Already have account Login!')),
              Image.asset('images/icon_image.jpg')
          
            ],
          ),
        ),
      ),
    );
  }
}
