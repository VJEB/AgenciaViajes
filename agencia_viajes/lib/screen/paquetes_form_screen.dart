import 'dart:convert';

import 'package:agencia_viajes/models/detalle_de_paquete.dart';
import 'package:agencia_viajes/models/paquete.dart';
import 'package:agencia_viajes/screen/paquetes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaquetesForm extends StatefulWidget {
  const PaquetesForm({super.key});

  @override
  State<PaquetesForm> createState() => _PaquetesState();
}

class _PaquetesState extends State<PaquetesForm> {
  List<DetalleDePaquete> _detalles = [];

  Future<List<DetalleDePaquete>>? _detallesFuture;

  @override
  void initState() {
    super.initState();
    _detallesFuture ??= _cargarDetalles();
  }

  Future<List<DetalleDePaquete>> _cargarDetalles() async {
    List<DetalleDePaquete> list = [];
    const url = "https://etravel.somee.com/API/DetallePorPaquete/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> estadosCivilesJson = jsonDecode(respuesta.body);
        list = estadosCivilesJson
            .map((json) => DetalleDePaquete.fromJson(json))
            .toList();
        if (list.isNotEmpty) {
          ////////////////////////////////
        } else {
          print('Error al cargar los detalles');
        }
      });
    }
    return list;
  }

  void guardarDetalleDePaquete(BuildContext context,
      [bool mounted = true]) async {
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const Dialog(
            // The background color
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xC6FFFFFF), // You can adjust the color here
                width: 0.5, // You can adjust the width here
              ),
            ),
            backgroundColor: Color.fromARGB(211, 0, 0, 0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Cargando...')
                ],
              ),
            ),
          );
        });

    await postDetalleDePaquete();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> postDetalleDePaquete() async {
    const String url = "https://localhost:44372/API/DetallePorPaquete/Create";
    Paquete paquete = Paquete(
        paquId: 0,
        paquNombre: "aa",
        paquUsuaCreacion: 1,
        paquFechaCreacion: DateTime.now().toUtc().toIso8601String(),
        persId: 1);

    var resultado = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(paquete.toJson()),
    );

    if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[400], content: const Text('Exito?')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[400],
            content: const Text('Ya existe un paquete con ese nombre')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nombre del paquete",
          style: TextStyle(color: Color(0xFFFFBD59)),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFBD59)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Paquetes()),
            );
          },
        ),
        actions: <Widget>[],
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      body: ListView(
        reverse: true, // This will make the list view start from the bottom
        children: [
          Card(
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  FutureBuilder<List<DetalleDePaquete>>(
                    future: _detallesFuture,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listadoPaquetes(List<dynamic>? info) {
    List<Widget> lista = [];
    if (info != null) {
      for (var element in info) {
        lista.add(Text(element["name"]));
      }
    }
    return lista;
  }
}
