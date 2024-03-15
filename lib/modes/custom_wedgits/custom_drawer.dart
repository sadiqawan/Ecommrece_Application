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
              onTap: (){ Navigator.pop(context);},
              leading: const  Icon(Icons.home_filled),
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
               onTap: (){
                 context.read<LoginProvider>().logOut();
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));

               },
              leading: const  Icon(Icons.logout),
              title: const Text('LogOut'),
            ),

          ],
        ));
  }
}
