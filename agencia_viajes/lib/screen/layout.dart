import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'package:agencia_viajes/screen/dashboard_screen.dart';
import 'package:agencia_viajes/screen/hoteles_screen.dart';
import 'package:flutter/material.dart';
// import 'package:agencia_viajes/screen/usuarios_screen1.dart';
import 'package:agencia_viajes/screen/perfil_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:agencia_viajes/models/usuario.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;
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

    if (usuaId != null && usuaUsuario != null && usuaContra != null) {
      setState(() {
        _usuario = UsuarioModel(
          usuaId: usuaId,
          usuaUsuario: usuaUsuario,
          usuaContra: usuaContra,
        );
      });
    } else {}
  }

  final List<Widget> _widgetOptions = <Widget>[
     Graficos(),
    const Hoteles(),
    ProfileScreen(),
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
  // Verificar si el usuario está autenticado solo para la pantalla de perfil
  if (_selectedIndex == 2 && (_usuario.usuaId == null || _usuario.usuaId == -1)) {
    // Si el usua_Id es nulo o -1 y se está en la pantalla de perfil, redirigir a la pantalla de inicio de sesión
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicioSesion()),
      );
    });
    // Retornar un contenedor vacío mientras se redirige
    return Container();
  } else {
    // Si el usuario está autenticado o no se está en la pantalla de perfil, mostrar el layout normalmente
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _appBarTitles[_selectedIndex],
          style: TextStyle(color: Color(0xFFFFBD59)),
        ),
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

}
