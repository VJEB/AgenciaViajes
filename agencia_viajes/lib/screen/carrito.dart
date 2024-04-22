import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/screen/paquetes.dart';
import 'package:http/http.dart' as http;

class Carrito extends StatefulWidget {
  const Carrito({Key? key}) : super(key: key);

  @override
  State<Carrito> createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  String url = "https://etravel.somee.com/API/Hotel/HotelesList/0501";
  List<Map<String, dynamic>> carrito = [];

  @override
  void initState() {
    super.initState();
    _cargarCarrito();
  }

  Future<void> _cargarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String carritoJson = prefs.getString('carrito') ?? '[]';
    setState(() {
      carrito = jsonDecode(carritoJson).cast<Map<String, dynamic>>();
    });
  }

  Future<void> _guardarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carrito', jsonEncode(carrito));
  }

  Future<dynamic> _getListado() async {
    // Obtener la lista de hoteles del servidor
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  void _eliminarElementoDelCarrito(Map<String, dynamic> elemento) {
    setState(() {
      carrito.remove(elemento);
    });
    _guardarCarrito();
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
              MaterialPageRoute(builder: (_) => Paquetes()),
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
                children: _buildCarritoList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCarritoList() {
    List<Widget> lista = [];
    // Agrupar elementos del carrito por nombre y precio
    final Map<String, dynamic> groupedCarrito = {};
    carrito.forEach((element) {
      final key = '${element["paqu_Nombre"]}_${element["paqu_Precio"]}';
      groupedCarrito[key] ??= [];
      groupedCarrito[key].add(element);
    });
    // Construir la lista de elementos agrupados
    groupedCarrito.forEach((key, value) {
      final cantidad = value.length;
      final element = value.first;
      lista.add(
        Card(
          color: Colors.white10,
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              InkWell(
                splashColor: const Color.fromARGB(255, 255, 239, 120).withAlpha(30),
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
                          Row(
                            children: [
                              _buildQuantityCircle(cantidad),
                              const SizedBox(width: 8),
                              Text(
                                '${element["paqu_Nombre"]}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFFFBD59),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Espacio reservado para el icono de eliminar
                          SizedBox(width: 24),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Precio: L.${element["paqu_Precio"]}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    _eliminarElementoDelCarrito(element);
                  },
                ),
              ),
              
            ],
          ),
        ),
      );
    });
    return lista;
  }

  Widget _buildQuantityCircle(int cantidad) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$cantidad',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
