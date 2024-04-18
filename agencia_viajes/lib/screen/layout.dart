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
