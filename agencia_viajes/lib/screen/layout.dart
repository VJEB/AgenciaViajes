import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'package:agencia_viajes/screen/dashboard_screen.dart';
import 'package:agencia_viajes/screen/hoteles_screen.dart';
import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:flutter/material.dart';
// import 'package:agencia_viajes/screen/usuarios_screen1.dart';
import 'package:agencia_viajes/screen/perfil_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    const Graficos(),
    const Hoteles(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = [
    'Dashboards',
    'Hoteles',
    'Perfil',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _appBarTitles[_selectedIndex],
          style: TextStyle(color: Color(0xFFFFBD59)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InicioSesion()),
              );
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      drawer: MenuLateral(
        context: context,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_rounded),
            label: 'Gráficos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Hoteles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFFBD59),
        unselectedItemColor:
            Colors.grey, // Change the color of unselected items
        selectedLabelStyle: const TextStyle(
            color:
                Color(0xFFFFBD59)), // Change the label color of selected item
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        onTap: _onItemTapped,
      ),
    );
  }
}
