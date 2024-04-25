import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'carrito.dart';
import 'package:agencia_viajes/models/facutra.dart';
import 'package:agencia_viajes/models/facturaDetalle.dart';

class ConfirmarPago extends StatefulWidget {
  const ConfirmarPago({Key? key}) : super(key: key);

  @override
  State<ConfirmarPago> createState() => _ConfirmarPagoState();
}



class _ConfirmarPagoState extends State<ConfirmarPago> {
  String url = "https://etravel.somee.com/API/Persona/CargarTarjetas/1";

  List<Map<String, dynamic>> carrito = [];
  double subtotal = 0;
  double impuesto = 0;
  double totalPagar = 0;
  final double impuestoPorcentaje = 0.15; 
  String? _selectedCard; 

  List<String> opcionesTarjeta = [];

  @override
  void initState() {
    super.initState();
    _cargarCarrito();
    _cargarOpcionesTarjeta();
  }

  Future<void> _cargarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String carritoJson = prefs.getString('carrito') ?? '[]';
    setState(() {
      carrito = jsonDecode(carritoJson).cast<Map<String, dynamic>>();
      _calcularTotales();
    });
  }

  Future<void> _guardarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carrito', jsonEncode(carrito));
  }

  Future<void> _getListado() async {
 
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  void _calcularTotales() {
    subtotal = 0;
    impuesto = 0;
    totalPagar = 0;

    // Calcular subtotal
    carrito.forEach((element) {
      subtotal += element["paqu_Precio"];
    });
    impuesto = subtotal * impuestoPorcentaje;
    totalPagar = subtotal + impuesto;
  }

  Future<void> _cargarOpcionesTarjeta() async {
    final response = await http.get(Uri.parse(url)); 
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<String> opciones = [];
      for (var option in data) {
        opciones.add(option['paTa_Descripcion']);
      }
      setState(() {
        opcionesTarjeta = opciones;
      });
    } else {
      throw Exception('Failed to load card options');
    }
  }

Future<void> _confirmarCompra() async {
 
  final factura = Factura(
    factId: 0, 
    factFecha: DateTime.now().toUtc().toIso8601String(), 
    metoId: 1 , 
    pagoId: 1, 
    persId: 1, 
    factUsuaCreacion: 1,
    factFechaCreacion: DateTime.now().toUtc().toIso8601String(),
  );


  final facturaJson = factura.toJson();


  final response = await http.post(
    Uri.parse('https://localhost:44372/API/Factura/Create'), 
    headers:{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(facturaJson),
  );

   

  if (response.statusCode == 200) {

    final facturaId = int.parse(jsonDecode(response.body)['message']);
   
    _insertarDetalleFactura(facturaId);
  } else {
  
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Error al confirmar la compra. Por favor, inténtalo de nuevo.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

Future<void> _insertarDetalleFactura(int facturaId) async {
  
  final detalles = carrito.map((element) {

    return FacturaDetalle(
      fdetId: 0, 
      factId: facturaId, 
      paquId: element['paqu_Id'],
      factCantidadPaqu: 1, 
      fdetSubTotal: subtotal, 
      fdetTotal: totalPagar, 
      fdetImpuesto: impuesto, 
    );
  }).toList();


  final detallesJson = detalles.map((detalle) => detalle.toJson()).toList();

  final response = await http.post(
    Uri.parse('https://localhost:44372/API/Factura/CreateDetalle'), 
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(detallesJson),
  );

  if (response.statusCode == 200) {
  
    print('Detalles de factura insertados con éxito');
  } else {
  
    print('Error al insertar detalles de factura');
  }
}


  void _mostrarOpcionesTarjeta() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text(
                "Seleccione una Tarjeta",
                style: TextStyle(color: Color(0xFFFFBD59), fontSize: 19),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var option in opcionesTarjeta)
                      RadioListTile<String>(
                        title: Text(option, style: TextStyle(color: Colors.white),
                        ),
                        value: option,
                        groupValue: _selectedCard,
                        onChanged: (value) {
                          setState(() {
                            _selectedCard = value!;
                          });
                        },
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo sin seleccionar nada
                  },
                  child: Text(
                    "Cerrar",
                    style: TextStyle(color: Color(0xFFFFBD59)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para procesar la selección de la tarjeta
                    Navigator.of(context).pop(); // Cerrar el diálogo después de la selección
                  },
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black12)),
                  child: Text("Aceptar", style: TextStyle(color: Color(0xFFFFBD59)),),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _cargarCarrito(); 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Detalle de Compra',
              style: TextStyle(color: Colors.white),
            ),
          ],
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
              SizedBox(height: 20), 
              _buildCarritoList(),
              SizedBox(height: 20), 
              _buildTotals(), 
              SizedBox(height: 20), 
              Card(
                color: Colors.white10,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16), 
                  child: Column(
                    children: [
                      Text(
                        'Métodos de Pago',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15), // Espacio entre el texto y los iconos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPaymentMethodCard(
                              Icons.credit_card, "Tarjeta", Colors.blue, _mostrarOpcionesTarjeta), // Tarjeta
                          _buildPaymentMethodCard(Icons.attach_money, "Efectivo", Colors.green, () {}), // Efectivo
                          _buildPaymentMethodCard(Icons.book, "Cheque", Colors.orange, () {}), // Cheque
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 200), // Espacio adicional después de las opciones de pago
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
  color: Colors.black12, // Fondo gris
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: ElevatedButton.icon(
      onPressed: () {
        _confirmarCompra();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFFFFBD59)),
        iconColor: MaterialStateProperty.all(Colors.black),
      ),
      icon: Icon(Icons.arrow_forward), 
      label: Text("Confirmar Pago", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
    ),
  ),
),

    );
  }

  Widget _buildPaymentMethodCard(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return Card(
      color: Colors.black54,
      elevation: 4, // Añade elevación para resaltar la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 40),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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

  Widget _buildTotals() {
    return Card(
      color: Colors.white10,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinea los elementos hacia los extremos
              children: [
                Text(
                  'Subtotal:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'L.$subtotal',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinea los elementos hacia los extremos
              children: [
                Text(
                  'Impuesto:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'L.$impuesto',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(color: Colors.white),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinea los elementos hacia los extremos
              children: [
                Text(
                  'Total a pagar:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFBD59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'L.$totalPagar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFBD59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
