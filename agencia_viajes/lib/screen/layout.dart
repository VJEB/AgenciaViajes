import 'package:agencia_viajes/screen/hoteles_screen.dart';
import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:flutter/material.dart';

import 'package:agencia_viajes/screen/usuarios_screen1.dart';
import 'package:agencia_viajes/screen/paquetes_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key}); // Agrega el constructor key
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;

  // Lista de páginas para cada ícono
  final List<Widget> _widgetOptions = <Widget>[
    const Paquetes(),
    const Hoteles(),
    Usuarios(),
  ];

  // Función para cambiar de página al hacer clic en un ícono
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: 'Iniciar sesión',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const InicioSesion()));
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // Página seleccionada
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Listar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex, // Índice de la página seleccionada
        onTap: _onItemTapped, // Función para manejar el evento de clic
      ),
    );
  }
}
