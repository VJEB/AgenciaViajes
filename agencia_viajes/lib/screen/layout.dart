import 'package:agencia_viajes/screen/hoteles_screen.dart';
import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/screen/usuarios_screen1.dart';
import 'package:agencia_viajes/screen/paquetes_screen.dart';
import 'package:agencia_viajes/screen/carrito.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    const Paquetes(),
    const Hoteles(),
    Usuarios(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _cerrarSesion() {
    // Aquí puedes agregar la lógica para cerrar sesión
    // Por ejemplo, puedes navegar a la pantalla de inicio de sesión
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const InicioSesion()));
  }
 void _carrito() {
    // Aquí puedes agregar la lógica para cerrar sesión
    // Por ejemplo, puedes navegar a la pantalla de inicio de sesión
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  ShoppingCart()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.trolley),
            tooltip: 'Carrito',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) =>  ShoppingCart()));
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(''),
                      accountEmail: Text(''),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage('lib/assets/Logo-agencia-viajes.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: Icon(Icons.home, color: Color(0xFFFFBD59)),
                        title: Text('Paquetes', style: TextStyle(color: Color(0xFFFFBD59))),
                        onTap: () {
                          // Aquí puedes agregar la lógica para navegar a la página de inicio, por ejemplo.
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: Icon(Icons.trolley, color: Color(0xFFFFBD59)),
                        title: Text('Facturas', style: TextStyle(color: Color(0xFFFFBD59))),
                        onTap: () {
                          // Aquí puedes agregar la lógica para navegar a la página de listar, por ejemplo.
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: Icon(Icons.person, color: Color(0xFFFFBD59)),
                        title: Text('Administrar Usuarios', style: TextStyle(color: Color(0xFFFFBD59))),
                        onTap: () {
                          // Aquí puedes agregar la lógica para navegar a la página de perfil, por ejemplo.
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Color(0xFFFFBD59),
                alignment: Alignment.center,
                child: GestureDetector(
                  
                  onTap: _cerrarSesion,
                  child: const Text(
                    'Salir',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    
                  ),
                
                ),
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

