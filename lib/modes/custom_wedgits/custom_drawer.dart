import 'package:ecommrece_application/controls/providers/auth_provider.dart';
import 'package:ecommrece_application/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Container(
            color: Colors.black,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_basket_outlined,
                  color: Colors.white,
                ),
                Text(
                  'bagzz',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: const Icon(Icons.home_filled),
          title: const Text('Home'),
        ),
        const ListTile(
          leading: Icon(Icons.phone),
          title: Text('Contact'),
        ),
        const ListTile(
          leading: Icon(Icons.email_outlined),
          title: Text('Email'),
        ),
        ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Log Out"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the alert dialog
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<LoginProvider>().logOut();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text("Log Out"),
                    ),
                  ],
                );
              },
            );
          },
          leading: const Icon(Icons.logout),
          title: const Text('LogOut'),
        ),
      ],
    ));
  }
}
