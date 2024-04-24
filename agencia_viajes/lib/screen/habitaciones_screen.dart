import 'dart:convert';

import 'package:agencia_viajes/models/ciudad.dart';
import 'package:agencia_viajes/models/estado.dart';
import 'package:agencia_viajes/models/hotel.dart';
import 'package:agencia_viajes/models/pais.dart';
import 'package:agencia_viajes/models/place.dart';
import 'package:agencia_viajes/models/profile.dart';
import 'package:agencia_viajes/screen/hotel_screen.dart';
import 'package:agencia_viajes/screen/layout.dart';
import 'package:agencia_viajes/screen/transportes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Habitaciones extends StatefulWidget {
  final Hotel hotel;
  const Habitaciones({super.key, required this.hotel});

  @override
  State<Habitaciones> createState() => _HabitacionesState();
}

class _HabitacionesState extends State<Habitaciones> {
  String url = "https://etravel.somee.com/API/Hotel/HotelesList/1";

  late Hotel hotel;

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
    hotel = widget.hotel;
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
      appBar: AppBar(
        title: Text(
          hotel.hoteNombre,
          style: const TextStyle(color: Color(0xFFFFBD59)),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Layout()));
          },
        ),
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
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
                                  fontSize: 16,
                                  color: Color(0xFFFFBD59),
                                ),
                              ),
                            ),
                            // Text(
                            //   'Noche: L.${hotelData["haHo_PrecioPorNoche"]}',
                            //   style: const TextStyle(
                            //     fontSize: 20,
                            //     color: Color.fromARGB(255, 44, 214, 50),
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bed,
                              color: Colors.yellow,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${hotelData["hote_Estrellas"]}',
                              style: const TextStyle(
                                fontSize: 16,
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
                                'Noche: L.${hotelData["haHo_PrecioPorNoche"]}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 44, 214, 50),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                              // Text(hotelData["hote_DireccionExacta"],
                              // style: const TextStyle(
                              //   fontSize: 12,
                              //   color: Colors.white,
                              // softWrap: true,
                              // ),
                            ),
                            // ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       hotelData["ciud_Descripcion"],
                            //       style: const TextStyle(
                            //         fontSize: 12,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     Text(
                            //       hotelData["pais_Descripcion"],
                            //       style: const TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ],
                            // )
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
              isExpanded ? Icons.arrow_right : Icons.arrow_right,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
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
                          ciudId: 1,
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