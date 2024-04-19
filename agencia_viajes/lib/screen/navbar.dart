import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child:  ListView(
        padding: EdgeInsets.zero,
        children: const [
          
          UserAccountsDrawerHeader(
            accountName: Text(''),
             accountEmail: Text(''),

             decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(image: AssetImage('lib/assets/Logo-agencia-viajes.png')),
             ),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Upload'),
            
          ),
        ],
      ),
    );
  }
}