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
            tooltip: 'Iniciar sesión',
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
                        title: Text('Home', style: TextStyle(color: Color(0xFFFFBD59))),
                        onTap: () {
                          // Aquí puedes agregar la lógica para navegar a la página de inicio, por ejemplo.
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: Icon(Icons.trolley, color: Color(0xFFFFBD59)),
                        title: Text('Listar', style: TextStyle(color: Color(0xFFFFBD59))),
                        onTap: () {
                          // Aquí puedes agregar la lógica para navegar a la página de listar, por ejemplo.
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: Icon(Icons.person, color: Color(0xFFFFBD59)),
                        title: Text('Perfil', style: TextStyle(color: Color(0xFFFFBD59))),
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



// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   // int _selectedIndex = 1;

//   // final List<Widget> _widgetOptions = <Widget>[
//   //   const Paquetes(),
//   //   const Home(),
//   //   Usuarios(),
//   // ];

//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //   });
//   // }

//   String url = "https://localhost:44372/API/Hotel/HotelesList/0501";

//   Future<dynamic> _getListado() async {
//     final result = await http.get(Uri.parse(url));
//     if (result.statusCode >= 200) {
//       return jsonDecode(result.body);
//     } else {
//       print("Error en el endPoint");
//       // return const Center(child: Text("Error en el endPoint"));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight + 1),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: const Color(0xFFFFBD59).withOpacity(0.5),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: AppBar(
//             backgroundColor: Colors.black,
//             title:
//                 const Text("Index", style: TextStyle(color: Color(0xFFFFBD59))),
//             actions: <Widget>[
//               IconButton(
//                 icon: const Icon(Icons.login),
//                 tooltip: 'Iniciar sesión',
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => const InicioSesion()));
//                 },
//               ),
//             ],
//             iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
//           ),
//         ),
//       ),
//       body: FutureBuilder<dynamic>(
//         future: _getListado(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView(
//               children: listadoPaquetes(snapshot.data),
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }

//   List<Widget> listadoPaquetes(List<dynamic>? info) {
//     List<Widget> lista = [];
//     if (info != null) {
//       for (var element in info) {
//         lista.add(
//           Card(
//             color: Colors.white10,
//             clipBehavior: Clip.hardEdge,
//             child: InkWell(
//               splashColor:
//                   const Color.fromARGB(255, 255, 239, 120).withAlpha(30),
//               onTap: () {
//                 debugPrint('Card tapped.');
//               },
//               child: SizedBox(
//                 height: 100,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: CachedNetworkImage(
//                           imageUrl: element["hote_Imagen"],
//                           fit: BoxFit.cover,
//                           placeholder: (context, url) => const Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         )),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 4.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   '${element["hote_Nombre"]}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Color(0xFFFFBD59),
//                                   ),
//                                 ),
//                                 Text(
//                                   'Desde: L.${element["haHo_PrecioPorNoche"]}',
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     color: Color.fromARGB(255, 44, 214, 50),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 4.0),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   '${element["hote_Estrellas"]}',
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 30),
//                                 const Text(
//                                   'Estrellas',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 4.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   element["hote_DireccionExacta"],
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       element["ciud_Descripcion"],
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       element["pais_Descripcion"],
//                                       style: const TextStyle(
//                                         fontSize: 11,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     }
//     return lista;
//   }
// }
