import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'package:agencia_viajes/screen/hoteles_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/screen/usuarios_screen1.dart';
import 'package:agencia_viajes/screen/paquetes_form_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    const PaquetesForm(),
    const Hoteles(),
    Usuarios(),
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
        actions: <Widget>[],
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
