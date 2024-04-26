import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:agencia_viajes/screen/layout.dart';
import 'package:agencia_viajes/screen/paquetes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agencia_viajes/screen/transportes.dart';
import 'package:agencia_viajes/screen/usuarios_screen1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/models/usuario.dart';
import 'package:agencia_viajes/screen/facturas.dart';


class MenuLateral extends StatefulWidget {
  
  const MenuLateral({super.key});

  @override
  State<MenuLateral> createState() => _MenuLateral();
}

class _MenuLateral extends State<MenuLateral> {
  // final BuildContext context;
  
 late UsuarioModel _usuario = UsuarioModel(usuaId: -1);
  
@override
  void initState() {
    super.initState();
    _loadUsuario();
  }


   Future<void> _loadUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final int? usuaId = prefs.getInt('usua_Id');
    final String? usuaUsuario = prefs.getString('usua_Usuario');
    final String? usuaContra = prefs.getString('usua_Contra');
    final String? usuaAdmin = prefs.getString('usua_Admin');

    if (usuaId != null && usuaUsuario != null && usuaContra != null) {
      setState(() {
        _usuario = UsuarioModel(
          usuaId: usuaId,
          usuaUsuario: usuaUsuario,
          usuaContra: usuaContra,
          usuaAdmin: bool.parse(usuaAdmin as String),
        );
      });
    } else {}
  }
  void _inicio() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Layout()));
  }

  void _cerrarSesion() async {
  // Obtiene una instancia de SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Limpia los valores de SharedPreferences
  await prefs.remove('usua_Id');
  await prefs.remove('usua_Usuario');
  await prefs.remove('usua_Contra');
  await prefs.remove('carrito');
  // Redirige al usuario al Layout
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const Layout()),
  );
}

  void _paquetes() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Paquetes()));
  }
 void _transportes() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Transportes()));
  }
   void _AdministrarUsuarios() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Usuarios()));
  }

    void _Facturas() {
        if ((_usuario.usuaId == null || _usuario.usuaId == -1)) {

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicioSesion()),
      );
    });
  } else {
  Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => ApiScreen()));
  }
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
                      leading: const Icon(Icons.airplanemode_active, color: Color(0xFFFFBD59)),
                      title: const Text('Transportes',
                          style: TextStyle(color: Color(0xFFFFBD59))),
                      onTap: _transportes,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListTile(
                      leading: const FaIcon(FontAwesomeIcons.fileInvoice,
                          color: Color(0xFFFFBD59)),
                      title: const Text('Facturas',
                          style: TextStyle(color: Color(0xFFFFBD59))),
                      onTap: _Facturas,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListTile(
                      leading:
                          const Icon(Icons.people, color: Color(0xFFFFBD59)),
                      title: const Text('Administrar Usuarios',
                          style: TextStyle(color: Color(0xFFFFBD59))),
                      onTap: _AdministrarUsuarios,
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
                  color: Color(0xFFFFBD59),
                ),
                label: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: Color(0xFFFFBD59), // Cambio de color del texto
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Cambio de color del botón
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
