import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:agencia_viajes/screen/layout.dart';
import 'package:agencia_viajes/screen/carrito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paquete extends StatefulWidget {
  const Paquete({Key? key}) : super(key: key);

  @override
  State<Paquete> createState() => _PaqueteState();
}

class _PaqueteState extends State<Paquete> {
  String url = "https://etravel.somee.com/API/Hotel/HotelesList/0501";
  List<dynamic> carrito = [];

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
  void initState() {
    super.initState();
    _cargarCarrito();
  }

  void _cargarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final carritoJson = prefs.getString('carrito');
    if (carritoJson != null) {
      setState(() {
        carrito = jsonDecode(carritoJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFBD59)),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Layout()));
          },
        ),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.trolley),
                tooltip: 'Iniciar sesión',
                onPressed: () {
                  _mostrarCarrito(context);
                },
              ),
              if (carrito.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                    child: Text(
                      '${carrito.length}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder<dynamic>(
              future: _getListado(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CarouselWithHoteles(listadoHoteles: snapshot.data, agregarAlCarrito: _agregarAlCarrito);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Expanded(
              child: FutureBuilder<dynamic>(
                future: _getListado(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(top: 15),
                          color: Colors.white10,
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            splashColor: const Color.fromARGB(255, 255, 239, 120).withAlpha(30),
                            onTap: () {
                              _mostrarDetalles(context, snapshot.data![index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${snapshot.data![index]["hote_Nombre"]}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFFFFBD59),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _agregarAlCarrito(snapshot.data![index]);
                                        },
                                        child: Text('Agregar'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Precio: L.${snapshot.data![index]["haHo_PrecioPorNoche"]}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Lógica para editar
                                        },
                                        child: Text('Editar'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para agregar un nuevo elemento
          // Puedes agregar aquí la lógica para abrir una nueva pantalla o realizar una acción al hacer clic en el botón de más
        },
        backgroundColor: Colors.black, // Cambia el color de fondo del botón flotante
        child: Icon(Icons.add, color: Color(0xFFFFBD59)), // Icono de más con color blanco
      ),
    );
  }

  void _agregarAlCarrito(dynamic item) async {
    setState(() {
      carrito.add(item);
    });
    await _guardarCarrito();
  }

  Future<void> _guardarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carrito', jsonEncode(carrito));
  }

  void _mostrarDetalles(BuildContext context, dynamic hotel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del Hotel'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nombre: ${hotel["hote_Nombre"]}'),
                Text('Precio por Noche: L.${hotel["haHo_PrecioPorNoche"]}'),
                // Agrega más detalles aquí si es necesario
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarCarrito(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Carrito()));
  }
}

class CarouselWithHoteles extends StatelessWidget {
  final List<dynamic>? listadoHoteles;
  final Function(dynamic) agregarAlCarrito;

  const CarouselWithHoteles({Key? key, this.listadoHoteles, required this.agregarAlCarrito}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: listadoHoteles!.map<Widget>((hotel) {
        return Card(
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${hotel["hote_Nombre"]}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFBD59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Precio: L.${hotel["haHo_PrecioPorNoche"]}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      agregarAlCarrito(hotel);
                    },
                    child: Text('Agregar'),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
