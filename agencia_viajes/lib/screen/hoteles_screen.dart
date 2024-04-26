import 'dart:convert';
import 'package:agencia_viajes/models/ciudad.dart';
import 'package:agencia_viajes/models/estado.dart';
import 'package:agencia_viajes/models/hotel.dart';
import 'package:agencia_viajes/models/pais.dart';
import 'package:agencia_viajes/screen/habitaciones_screen.dart';
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

  List<dynamic> _hoteles = [];
  List<dynamic> _paises = [];
  List<dynamic> _estados = [];
  List<dynamic> _ciudades = [];

  int? _paisSeleccionado;
  int? _estadoSeleccionado;
  int? _ciudadSeleccionada;

  Future<void> _cargarPaises() async {
    final url = "https://etravel.somee.com/API/Pais/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> paisesJson = jsonDecode(respuesta.body);
      setState(() {
        _paises = paisesJson;
      });
    } else {
      print('Error al cargar los países');
    }
  }

  Future<void> _cargarEstados(int paisId) async {
    final url = "https://etravel.somee.com/API/Estado/List/$paisId";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> estadosJson = jsonDecode(respuesta.body);
      setState(() {
        _estados = estadosJson;
      });
    } else {
      print('Error al cargar los estados');
    }
  }

  Future<void> _cargarCiudades(int estadoId) async {
    final url = "https://etravel.somee.com/API/Ciudad/List/$estadoId";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> ciudadesJson = jsonDecode(respuesta.body);
      setState(() {
        _ciudades = ciudadesJson;
      });
    } else {
      print('Error al cargar las ciudades');
    }
  }

  Future<void> _filtrarHoteles() async {
    String url = "https://etravel.somee.com/API/Hotel/HotelesList/";
    if (_ciudadSeleccionada != null) {
      url += "$_ciudadSeleccionada";
    }

    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200 && result.statusCode < 300) {
      setState(() {
        _hoteles = jsonDecode(result.body);
      });
    } else {
      print("Error en el endPoint");
    }
  }

  @override
  void initState() {
    super.initState();
    _cargarPaises();
  }


  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200 && result.statusCode < 300) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar'),
        
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              // Aquí puedes agregar alguna acción para filtrar
              _filtrarHoteles();
            },
            icon: Icon(Icons.filter_alt),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _paisSeleccionado,
                  items: _paises
                      .map(
                        (pais) => DropdownMenuItem<int>(
                          value: pais['pais_Id'],
                          child: Text(pais['pais_Descripcion']),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _paisSeleccionado = value;
                      _estadoSeleccionado = null;
                      _ciudadSeleccionada = null;
                      _cargarEstados(value!);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'País',
                    border: OutlineInputBorder(),
                    
                  ),
                ),
              ),
              SizedBox(width: 10),
               Expanded(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 50), // Establecer un ancho máximo para el dropdown
                  child: DropdownButtonFormField<int>(
                    value: _estadoSeleccionado,
                    items: _estados
                        .map(
                          (estado) => DropdownMenuItem<int>(
                            value: estado['esta_Id'],
                            child: Text(estado['esta_Descripcion']),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _estadoSeleccionado = value;
                        _ciudadSeleccionada = null;
                        _cargarCiudades(value!);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Estado',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _ciudadSeleccionada,
                  items: _ciudades
                      .map(
                        (ciudad) => DropdownMenuItem<int>(
                          value: ciudad['ciud_Id'],
                          child: Text(ciudad['ciud_Descripcion']),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _ciudadSeleccionada = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Ciudad',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
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
          ),
           SizedBox(width: 40),
        ],
        
      ),
      ),

     
    );
  }
  
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: FutureBuilder<dynamic>(
  //       future: _getListado(), 
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView(
  //             children: [
  //               ...listadoHotelesConCollapse(snapshot.data),
  //             ],
  //           );
  //         } else {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //       },
  //     ),
  //   );
  // }

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
      child: Padding(
         padding: const EdgeInsets.all(10.0),
        child:   Card(
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
              isExpanded ? Icons.arrow_right : Icons.arrow_right,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Habitaciones(
                          hotel: Hotel(
                              hoteId: hotelData["hote_Id"] ?? 0,
                              hoteNombre: hotelData["hote_Nombre"],
                              hoteDireccionExacta:
                                  hotelData["hote_DireccionExacta"],
                              ciudDescripcion: hotelData["ciud_Descripcion"],
                              ciudId: int.parse(hotelData["ciud_Id"]),
                              estaDescripcion: hotelData["esta_Descripcion"],
                              haHoPrecioPorNoche:
                                  hotelData["haHo_PrecioPorNoche"] ?? 0,
                              hoteEstado: hotelData["hote_Estado"] ?? 0,
                              hoteEstrellas: hotelData["hote_Estrellas"],
                              hoteTelefono: hotelData["hote_Telefono"],
                              hoteCorreo: hotelData["hote_Correo"],
                              hoteResena: hotelData["hote_Reseña"],
                              hoteFechaCreacion:
                                  hotelData["hote_Fecha_Creacion"],
                              hoteHoraSalida: "12:00:00",
                              // hotelData["hote_HoraSalida"].toString(),
                              hoteImagen: hotelData["hote_Imagen"],
                              hotePrecioTodoIncluido:
                                  hotelData["hote_PrecioTodoIncluido"] ?? 0,
                              hoteUsuaCreacion: hotelData["hote_Usua_Creacion"],
                              paisDescripcion: hotelData["pais_Descripcion"],
                              impuId: hotelData["impu_Id"],
                              impuDescripcion: hotelData["impu_Descripcion"],
                              paisPorcentajeImpuesto:
                                  hotelData["pais_PorcentajeImpuesto"]))));
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
      ), 
    
    );
  }
}
