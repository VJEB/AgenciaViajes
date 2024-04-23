import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/screen/carrito.dart';
import 'package:http/http.dart' as http;

class ConfirmarPago extends StatefulWidget {
  const ConfirmarPago({Key? key}) : super(key: key);

  @override
  State<ConfirmarPago> createState() => _ConfirmarPagoState();
}

class _ConfirmarPagoState extends State<ConfirmarPago> {
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

  @override
  Widget build(BuildContext context) {
    _cargarCarrito(); // Cargar el carrito cada vez que se construye la pantalla
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'RESUMEN',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFBD59)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Carrito()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20), // Espacio entre el borde superior y el texto "Detalle de Compra"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Detalle de Compra',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Espacio entre el texto y la lista de elementos del carrito
              _buildCarritoList(),
              SizedBox(height: 20), // Espacio entre la lista y las tarjetas de métodos de pago
              ListTile(
                leading: Icon(Icons.payment, color: Colors.white),
                title: Text(
                  'Métodos de pago',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40), // Agregado el padding horizontal
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPaymentMethodCard(Icons.credit_card ),
                    _buildPaymentMethodCard(Icons.attach_money),
                    _buildPaymentMethodCard(Icons.book),
                  ],
                ),
              ),
              SizedBox(height: 200), // Espacio adicional después de las tarjetas de métodos de pago
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(IconData icon) {
    return Card(
      color: Colors.white10,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCarritoList() {
    // Agrupar elementos del carrito por nombre y precio
    final Map<String, dynamic> groupedCarrito = {};
    carrito.forEach((element) {
      final key = '${element["paqu_Nombre"]}_${element["paqu_Precio"]}';
      groupedCarrito[key] ??= [];
      groupedCarrito[key].add(element);
    });

    // Construir la lista de elementos agrupados
    List<Widget> lista = [];
    groupedCarrito.forEach((key, value) {
      final cantidad = value.length;
      final element = value.first;
      lista.add(
        Card(
          color: Colors.white10,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(vertical: 10), // Agregado el margen vertical
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
            ],
          ),
        ),
      );
    });
    return Column(children: lista);
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
