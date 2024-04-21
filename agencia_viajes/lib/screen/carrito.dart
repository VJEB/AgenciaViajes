import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/screen/paquetes.dart';

class Carrito extends StatefulWidget {
  const Carrito({Key? key}) : super(key: key);

  @override
  State<Carrito> createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  String url = "https://etravel.somee.com/API/Hotel/HotelesList/0501";
  List<dynamic> carrito = [];

  @override
  void initState() {
    super.initState();
    _cargarCarrito();
  }

  Future<void> _cargarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String carritoJson = prefs.getString('carrito') ?? '[]';
    setState(() {
      carrito = jsonDecode(carritoJson);
    });
  }

  Future<void> _guardarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carrito', jsonEncode(carrito));
  }

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
    _cargarCarrito(); // Cargar el carrito cada vez que se construye la pantalla
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFBD59)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Paquete()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: listadoCarrito(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> listadoCarrito() {
    List<Widget> lista = [];
    for (var element in carrito) {
      lista.add(
        Card(
          color: Colors.white10,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor:
                const Color.fromARGB(255, 255, 239, 120).withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
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
                        '${element["hote_Nombre"]}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFBD59),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                carrito.remove(element);
                              });
                              _guardarCarrito();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.payment, color: Colors.white),
                            onPressed: () {
                              // Acción al pagar
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.visibility, color: Colors.white),
                            onPressed: () {
                              // Acción al ver
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Precio: L.${element["haHo_PrecioPorNoche"]}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return lista;
  }
}
