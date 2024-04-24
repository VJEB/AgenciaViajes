import 'dart:convert';

import 'package:agencia_viajes/models/hotel.dart';
import 'package:agencia_viajes/models/place.dart';
import 'package:agencia_viajes/models/profile.dart';
import 'package:agencia_viajes/screen/hotel_screen.dart';
import 'package:agencia_viajes/screen/layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Habitaciones extends StatefulWidget {
  final Hotel hotel;
  const Habitaciones({super.key, required this.hotel});

  @override
  State<Habitaciones> createState() => _HabitacionesState();
}

class _HabitacionesState extends State<Habitaciones> {
  String urlHabitaciones = "http://etravel.somee.com/API/HabitacionesCategorias/HabitacionPorHotelList/";

  late Hotel hotel;

  Map<int, bool> expansionState = {};

  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(urlHabitaciones));
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

  @override
  void initState() {
    super.initState();
    hotel = widget.hotel;
    urlHabitaciones += hotel.hoteId.toString(); 
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
                ...listadoHotelesConCollapse(snapshot.data, hotel),
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
    Hotel hotel,
  ) {
    List<Widget> lista = [];
    if (info != null) {
      for (var index = 0; index < info.length; index++) {
        final element = info[index];
        lista.add(
          HotelExpansionTile(
            hotel: hotel,
            habitacionesData: element,
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
  final Hotel hotel;
  final Map<String, dynamic> habitacionesData;
  final Future<List<dynamic>> Function(int) getFotosPorHotel;

  const HotelExpansionTile({
    required this.hotel,
    required this.habitacionesData,
    required this.getFotosPorHotel,
    super.key,
  });

  @override
  State<HotelExpansionTile> createState() => _HotelExpansionTileState();
}

class _HotelExpansionTileState extends State<HotelExpansionTile> {
  bool isExpanded = false;
  late Hotel hotel;
  Future<List<dynamic>> getFotosPorHotel(int hotelId) {
    return widget.getFotosPorHotel(hotelId);
  }

  @override
  void initState() {
    super.initState();
    hotel = widget.hotel;
  }

  @override
  Widget build(BuildContext context) {
    final habitacionesData = widget.habitacionesData;
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
                    imageUrl: habitacionesData["foHa_UrlImagen"] ?? "aaa",
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
                                '${habitacionesData["haCa_Nombre"]}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFFFBD59),
                                ),
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
                            const FaIcon(
                              FontAwesomeIcons.bed,
                              color: Colors.yellow,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${habitacionesData["habi_NumCamas"]}',
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
                                'Noche: L.${habitacionesData["haCa_PrecioPorNoche"]}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 44, 214, 50),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                            ),
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
                    builder: (_) => 
                    HotelScreen(
                      hotel: hotel,
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
              future: getFotosPorHotel(habitacionesData["hote_Id"]),
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
