import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hoteles extends StatefulWidget {
  const Hoteles({Key? key});

  @override
  State<Hoteles> createState() => _HotelesState();
}

class _HotelesState extends State<Hoteles> {
  String url = "https://etravel.somee.com/API/Hotel/HotelesList/1";
  
  // URL para obtener las fotos por hotel
  String fotosPorHotelUrl = "https://etravel.somee.com/API/Habitacion/FotoPorHotelList/";

  // Función para obtener la lista de hoteles
  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error en el endPoint");
      // return const Center(child: Text("Error en el endPoint"));
    }
  }

  // Función para obtener las fotos por hotel
  Future<dynamic> _getFotosPorHotel(int hotelId) async {
    final result = await http.get(Uri.parse("$fotosPorHotelUrl$hotelId"));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error al obtener las fotos por hotel");
      // return const Center(child: Text("Error al obtener las fotos por hotel"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: _getListado(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: listadoPaquetes(snapshot.data),
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
                        imageUrl: element["hote_Imagen"],
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
              children: [
                // Mostrar las fotos por hotel
                FutureBuilder<dynamic>(
                  future: _getFotosPorHotel(element["hote_Id"]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 100, // Altura de las imágenes
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data[index]["foHa_UrlImagen"],
                                fit: BoxFit.cover,
                                width: 100, // Ancho de cada imagen
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
              ],
            ),
          ),
        );
      }
    }
    return lista;
  }
}
