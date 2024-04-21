import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:agencia_viajes/screen/layout.dart';
import 'package:agencia_viajes/screen/paquetes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuLateral extends StatelessWidget {
  final BuildContext context;

  const MenuLateral({
    super.key,
    required this.context,
  });
  void _inicio() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Layout()));
  }

  void _cerrarSesion() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const InicioSesion()));
  }

  void _paquetes() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Paquetes()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const UserAccountsDrawerHeader(
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
                      leading: const Icon(Icons.home, color: Color(0xFFFFBD59)),
                      title: const Text('Inicio',
                          style: TextStyle(color: Color(0xFFFFBD59))),
                      onTap: _inicio,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListTile(
                      leading: const FaIcon(FontAwesomeIcons.boxOpen,
                          color: Color(0xFFFFBD59)),
                      title: const Text('Paquetes',
                          style: TextStyle(color: Color(0xFFFFBD59))),
                      onTap: _paquetes,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListTile(
                      leading: const FaIcon(FontAwesomeIcons.fileInvoice,
                          color: Color(0xFFFFBD59)),
                      title: const Text('Facturas',
                          style: TextStyle(color: Color(0xFFFFBD59))),
                      onTap: () {
                        // Aquí puedes agregar la lógica para navegar a la página de listar, por ejemplo.
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListTile(
                      leading:
                          const Icon(Icons.people, color: Color(0xFFFFBD59)),
                      title: const Text('Administrar Usuarios',
                          style: TextStyle(color: Color(0xFFFFBD59))),
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
              color: const Color(0xFFFFBD59),
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: _cerrarSesion,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                label: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
