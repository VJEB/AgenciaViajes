import 'dart:convert';

import 'package:agencia_viajes/models/hotel.dart';
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

  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error en el endPoint");
      // return const Center(child: Text("Error en el endPoint"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
          FutureBuilder<dynamic>(
            future: _getListado(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    
                    ...listadoPaquetes(snapshot.data)],
                    //                   children: 
                    
                    // listadoPaquetes(snapshot.data),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      }

  List<Widget> listadoPaquetes(List<dynamic>? info) {
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
        context, MaterialPageRoute(builder: (_) => HotelScreen(
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
            hoteImagen: "https://cdn2.thecatapi.com/images/b9r.jpg",
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
      ),));
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
}
