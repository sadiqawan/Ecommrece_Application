import 'package:flutter/material.dart';

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
            const ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Home'),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact'),
            ),
            const ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('Email'),
            ),
            const ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
            ),

          ],
        ));
  }
}
