import 'dart:convert';

import 'package:agencia_viajes/models/detalle_de_paquete.dart';
import 'package:agencia_viajes/models/paquete.dart';
import 'package:agencia_viajes/screen/paquetes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PaquetesForm extends StatefulWidget {
  final Paquete paquete;
  const PaquetesForm({super.key, required this.paquete});

  @override
  State<PaquetesForm> createState() => _PaquetesState();
}

class _PaquetesState extends State<PaquetesForm> {
  final _formKey = GlobalKey<FormState>();

  List<DetalleDePaquete> _detalles = [];

  Future<List<DetalleDePaquete>>? _detallesFuture;

  @override
  void initState() {
    super.initState();
    _detallesFuture ??= _cargarDetalles();
    paquete = widget.paquete;
    url += paquete.paquId.toString();
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

  late Paquete paquete;

  String _paqueteNombre = "";

  String url = "https://etravel.somee.com/API/Paquete/Edit/";

  void mostrarDialogNombre(BuildContext context, [bool mounted = true]) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Color(0xC6FFFFFF), // You can adjust the color here
            width: 0.5, // You can adjust the width here
          ),
        ),
        backgroundColor: const Color(0xC9040000),
        title: const Text(
          'Cambiar nombre del paquete',
          style: TextStyle(color: Color(0xFFFFBD59)),
        ),
        content: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              initialValue: paquete.paquNombre,
              style: const TextStyle(color: Color(0xFFFFBD59)),
              inputFormatters: [
                TextInputFormatter.withFunction(
                  (TextEditingValue oldValue, TextEditingValue newValue) {
                    return RegExp(r'^[a-zA-Z0-9\s]*$').hasMatch(newValue.text)
                        ? newValue
                        : oldValue;
                  },
                ),
              ],
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingrese el nombre del paquete';
                }
                return null;
              },
              onSaved: (value) => _paqueteNombre = value ?? '',
              decoration: const InputDecoration(
                labelText: 'Nombre del paquete',
                labelStyle: TextStyle(color: Color(0xFFFFBD59)),
                hintText: 'Vacaciones en Nueva Zelanda',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC28427)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFBD59)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SizedBox(
                    width: 150, // max width of the button
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await putNombreDelPaquete();
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                    ),
                  )
                ]))
          ]),
        ),
      ),
    );
  }

  Future<void> putNombreDelPaquete() async {
    Paquete paqu = Paquete(
        paquId: paquete.paquId,
        paquNombre: _paqueteNombre,
        paquUsuaCreacion: 0,
        paquFechaCreacion: DateTime.now().toUtc().toIso8601String(),
        paquUsuaModifica: 1,
        paquFechaModifica: DateTime.now().toUtc().toIso8601String(),
        persId: 1,
        paquPrecio: 0,
        paquEstado: 0);

    var resultado = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(paqu.toJson()),
    );

    if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
      setState(() {
        paquete.paquNombre = _paqueteNombre;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Color.fromARGB(255, 62, 208, 57),
            content: const Text('Nombre del paque actualizado con exito!')),
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
        title: Row(
          children: [
            Expanded(
              child: Text(
                paquete.paquNombre,
                style: const TextStyle(color: Color(0xFFFFBD59)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFFFFBD59)),
              onPressed: () {
                mostrarDialogNombre(context);
              },
            ),
          ],
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
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      body: ListView(
        reverse: true,
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
                        return Column(
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
