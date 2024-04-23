import 'dart:convert';

import 'package:agencia_viajes/models/ciudad.dart';
import 'package:agencia_viajes/models/estado.dart';
import 'package:agencia_viajes/models/hotel.dart';
import 'package:agencia_viajes/models/pais.dart';
import 'package:agencia_viajes/models/place.dart';
import 'package:agencia_viajes/models/profile.dart';
import 'package:agencia_viajes/screen/hotel_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hoteles extends StatefulWidget {
  const Hoteles({super.key});

  @override
  State<Hoteles> createState() => _HotelesState();
}

class _HotelesState extends State<Hoteles> {
  String url = "https://etravel.somee.com/API/Hotel/HotelesList/1";

  Map<int, bool> expansionState = {};

  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error en el endPoint");
      // return const Center(child: Text("Error en el endPoint"));
    }
  }

  String fotosPorHotelUrl =
      "https://etravel.somee.com/API/Habitacion/FotoPorHotelList/";

  Future<List<dynamic>> _getFotosPorHotel(int hotelId) async {
    final result = await http.get(Uri.parse("$fotosPorHotelUrl$hotelId"));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error al obtener las fotos por hotel");
      // You may want to throw an exception here or return an empty list
      throw Exception("Error al obtener las fotos por hotel");
    }
  }

  int _paisSeleccionado = 0;
  final List<Pais> _paises = [];

  int _estadoSeleccionado = 0;
  final List<Estado> _estados = [];

  int _ciudadSeleccionada = 0;
  final List<Ciudad> _ciudades = [];

  Future<List<Pais>>? _paisesFuture;
  Future<List<Estado>>? _estadosFuture;
  Future<List<Ciudad>>? _ciudadesFuture;

  @override
  void initState() {
    super.initState();
    _paisesFuture ??= _cargarPaises();
    _paisesFuture?.then((_) {
      _estadosFuture ??= _cargarEstados();
      _estadosFuture?.then((_) {
        _ciudadesFuture ??= _cargarCiudades();
      });
    });
  }

  Future<List<Pais>> _cargarPaises() async {
    List<Pais> list = [];
    const url = "https://etravel.somee.com/API/Pais/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> paisesJson = jsonDecode(respuesta.body);
      list = paisesJson.map((json) => Pais.fromJson(json)).toList();
      if (list.isNotEmpty) {
        _paisSeleccionado = list.first.paisId;
      } else {
        print('Error al cargar los paises');
      }
      // setState(() {
      // });
    }
    return list;
  }

  void _onPaisSelected(Pais selectedPais) {
    setState(() {
      _paisSeleccionado = selectedPais.paisId;
      _estados.clear();
    });
    _estadosFuture = _cargarEstados();
  }

  Future<List<Estado>> _cargarEstados() async {
    List<Estado> list = [];
    String url = "https://etravel.somee.com/API/Estado/List/$_paisSeleccionado";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> estadosJson = jsonDecode(respuesta.body);
        list = estadosJson.map((json) => Estado.fromJson(json)).toList();
        if (list.isNotEmpty) {
          _estadoSeleccionado = list.first.estaId;
        } else {
          print('Error al cargar los estados');
        }
      });
    }
    return list;
  }

  void _onEstadoSelected(Estado selectedEstado) {
    setState(() {
      _estadoSeleccionado = selectedEstado.estaId;
      _ciudades.clear();
    });
    _ciudadesFuture = _cargarCiudades();
  }

  Future<List<Ciudad>> _cargarCiudades() async {
    List<Ciudad> list = [];
    String url =
        "https://etravel.somee.com/API/Ciudad/List/$_estadoSeleccionado";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> estadosJson = jsonDecode(respuesta.body);
        list = estadosJson.map((json) => Ciudad.fromJson(json)).toList();
        if (list.isNotEmpty) {
          _estadoSeleccionado = list.first.estaId;
        } else {
          print('Error al cargar las ciudades');
        }
      });
    }
    return list;
  }

  void _onCiudadSelected(Ciudad selectedCiudad) {
    setState(() {
      _ciudadSeleccionada = selectedCiudad.ciudId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: _getListado(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                ...listadoHotelesConCollapse(snapshot.data),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> listadoHoteles(List<dynamic>? info) {
    List<Widget> lista = [];
    if (info != null) {
      for (var element in info) {
        lista.add(
          Card(
            color: Colors.white10,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor:
                  const Color.fromARGB(255, 255, 239, 120).withAlpha(30),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HotelScreen(
                        hotel: Hotel(
                            hoteId: 1,
                            hoteNombre: "Hotel",
                            hoteDireccionExacta: "Direccion",
                            hotePrecioTodoIncluido: 200,
                            haHoPrecioPorNoche: 500,
                            hoteEstrellas: 5,
                            ciudId: "ciudId",
                            ciudDescripcion: "DescripcionCiud",
                            estaDescripcion: "DescripcionEsta",
                            hoteEstado: 1,
                            hoteFechaCreacion: "FechaCreacion",
                            hoteHoraSalida: "HoraSalida",
                            hoteImagen:
                                "https://cdn2.thecatapi.com/images/b9r.jpg",
                            hoteUsuaCreacion: 1,
                            paisDescripcion: "pais"),
                        place: const Place(
                            address: "adress",
                            bathCount: 5,
                            bedCount: 5,
                            bedroomCount: 5,
                            city: "city",
                            costPerNight: 500,
                            country: "country",
                            guestCount: 50,
                            imageUrls: [
                              "https://cdn2.thecatapi.com/images/3ql.jpg",
                              "https://cdn2.thecatapi.com/images/9p2.jpg",
                              "https://cdn2.thecatapi.com/images/b9r.jpg"
                            ],
                            numberOfRatings: 500,
                            owner: Profile(
                              isSuperhost: true,
                              name: "owner",
                              profileImageUrl: "profileImageUrl",
                            ),
                            rating: 5,
                            state: "state",
                            title: "title",
                            type: PlaceType.apartment,
                            zipcode: "zipcode",
                            description: "description"),
                      ),
                    ));
              },
              child: SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: element["hote_Imagen"],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${element["hote_Nombre"]}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFFFBD59),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Desde: L.${element["haHo_PrecioPorNoche"]}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 44, 214, 50),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${element["hote_Estrellas"]}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  // Wrap the first Text widget with Expanded
                                  child: Text(
                                    element["hote_DireccionExacta"],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      element["ciud_Descripcion"],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      element["pais_Descripcion"],
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return lista;
  }

  List<Widget> listadoHotelesConCollapse(
    List<dynamic>? info,
  ) {
    List<Widget> lista = [];
    if (info != null) {
      for (var index = 0; index < info.length; index++) {
        final element = info[index];
        lista.add(
          HotelExpansionTile(
            hotelData: element,
            getFotosPorHotel: _getFotosPorHotel,
            // isExpanded: expansionState[index] ?? false,
            // onExpansionChanged: (bool isExpanded) {
            //   setState(() {
            //     expansionState[index] = isExpanded;
            //   });
            // },
          ),
        );
      }
    }
    return lista;
  }
}

class HotelExpansionTile extends StatefulWidget {
  final Map<String, dynamic> hotelData;
  final Future<List<dynamic>> Function(int) getFotosPorHotel;

  const HotelExpansionTile({
    required this.hotelData,
    required this.getFotosPorHotel,
    super.key,
  });

  @override
  State<HotelExpansionTile> createState() => _HotelExpansionTileState();
}

class _HotelExpansionTileState extends State<HotelExpansionTile> {
  bool isExpanded = false;
  Future<List<dynamic>> getFotosPorHotel(int hotelId) {
    return widget.getFotosPorHotel(hotelId);
  }

  @override
  Widget build(BuildContext context) {
    final hotelData = widget.hotelData;
    return GestureDetector(
      onTap: () {
        // Handle navigation to another route if necessary
      },
      child: Card(
        color: Colors.white10,
        clipBehavior: Clip.hardEdge,
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          textColor: Colors.white,
          collapsedTextColor: Colors.white,
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          childrenPadding: const EdgeInsets.all(16),
          title: SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    imageUrl: hotelData["hote_Imagen"],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                '${hotelData["hote_Nombre"]}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFFFBD59),
                                ),
                              ),
                            ),
                            Text(
                              'Desde: L.${hotelData["haHo_PrecioPorNoche"]}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 44, 214, 50),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${hotelData["hote_Estrellas"]}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              // Wrap the first Text widget with Expanded
                              child: Text(
                                hotelData["hote_DireccionExacta"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  hotelData["ciud_Descripcion"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  hotelData["pais_Descripcion"],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // ... same as before
          initiallyExpanded: isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() {
              isExpanded = expanded;
            });
          },
          trailing: IconButton(
            icon: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          children: [
            FutureBuilder<List<dynamic>>(
              future: getFotosPorHotel(hotelData["hote_Id"]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data![index]["foHa_UrlImagen"],
                            fit: BoxFit.cover,
                            width: 100,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ], //
        ),
      ),
    );
  }
}

// class HotelExpansionTile extends StatelessWidget {
//   final Map<String, dynamic> hotelData;
//   final Future<List<dynamic>> Function(int) getFotosPorHotel;
//   final bool isExpanded;
//   final Function(bool) onExpansionChanged;

//   const HotelExpansionTile({
//     required this.hotelData,
//     required this.getFotosPorHotel,
//     required this.isExpanded,
//     required this.onExpansionChanged,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Handle navigation to another route
//         // Example:
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
//       },
//       child: Card(
//         color: Colors.white10,
//         clipBehavior: Clip.hardEdge,
//         child: ExpansionTile(
//           tilePadding: EdgeInsets.zero,
//           textColor: Colors.white,
//           collapsedTextColor: Colors.white,
//           iconColor: Colors.white,
//           collapsedIconColor: Colors.white,
//           backgroundColor: Colors.transparent,
//           collapsedBackgroundColor: Colors.transparent,
//           childrenPadding: const EdgeInsets.all(16),
//           title: SizedBox(
//             height: 100,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: CachedNetworkImage(
//                     imageUrl: hotelData["hote_Imagen"],
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 4.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 '${hotelData["hote_Nombre"]}',
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xFFFFBD59),
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               'Desde: L.${hotelData["haHo_PrecioPorNoche"]}',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Color.fromARGB(255, 44, 214, 50),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 4.0),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.star,
//                               color: Colors.yellow,
//                               size: 12,
//                             ),
//                             const SizedBox(width: 5),
//                             Text(
//                               '${hotelData["hote_Estrellas"]}',
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 4.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               // Wrap the first Text widget with Expanded
//                               child: Text(
//                                 hotelData["hote_DireccionExacta"],
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.white,
//                                 ),
//                                 softWrap: true,
//                               ),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   hotelData["ciud_Descripcion"],
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 Text(
//                                   hotelData["pais_Descripcion"],
//                                   style: const TextStyle(
//                                     fontSize: 10,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           initiallyExpanded: isExpanded,
//           trailing: IconButton(
//             icon: Icon(
//               isExpanded ? Icons.expand_less : Icons.expand_more,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               setState(() {
//                 isExpanded = !isExpanded;
//               });
//             },
//           ),
//           children: [
//             FutureBuilder<List<dynamic>>(
//               future: getFotosPorHotel(hotelData["hote_Id"]),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return SizedBox(
//                     height: 100,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CachedNetworkImage(
//                             imageUrl: snapshot.data![index]["foHa_UrlImagen"],
//                             fit: BoxFit.cover,
//                             width: 100,
//                             placeholder: (context, url) => const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Usage:

// onExpansionChanged: (bool isExpanded) {
//   if (isExpanded) {
// Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(
//     builder: (_) => HotelScreen(
//       hotel: Hotel(
//           hoteId: 1,
//           hoteNombre: "Hotel",
//           hoteDireccionExacta: "Direccion",
//           hotePrecioTodoIncluido: 200,
//           haHoPrecioPorNoche: 500,
//           hoteEstrellas: 5,
//           ciudId: "ciudId",
//           ciudDescripcion: "DescripcionCiud",
//           estaDescripcion: "DescripcionEsta",
//           hoteEstado: 1,
//           hoteFechaCreacion: "FechaCreacion",
//           hoteHoraSalida: "HoraSalida",
//           hoteImagen:
//               "https://cdn2.thecatapi.com/images/b9r.jpg",
//           hoteUsuaCreacion: 1,
//           paisDescripcion: "pais"),
//       place: const Place(
//           address: "adress",
//           bathCount: 5,
//           bedCount: 5,
//           bedroomCount: 5,
//           city: "city",
//           costPerNight: 500,
//           country: "country",
//           guestCount: 50,
//           imageUrls: [
//             "https://cdn2.thecatapi.com/images/3ql.jpg",
//             "https://cdn2.thecatapi.com/images/9p2.jpg",
//             "https://cdn2.thecatapi.com/images/b9r.jpg"
//           ],
//           numberOfRatings: 500,
//           owner: Profile(
//             isSuperhost: true,
//             name: "owner",
//             profileImageUrl: "profileImageUrl",
//           ),
//           rating: 5,
//           state: "state",
//           title: "title",
//           type: PlaceType.apartment,
//           zipcode: "zipcode",
//           description: "description"),
//     ),
//   ),
// );
//   }
// },
