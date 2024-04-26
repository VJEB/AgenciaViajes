import 'dart:convert';

import 'package:agencia_viajes/models/paquete.dart';
import 'package:agencia_viajes/models/reservacion.dart';
import 'package:agencia_viajes/models/viaje.dart';
import 'package:agencia_viajes/screen/layout.dart';
import 'package:agencia_viajes/screen/paquetes.dart';
import 'package:agencia_viajes/screen/transportes.dart';
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

  Map<String?, int> uniqueHaCaNombres = {};
  List<Widget> lista = [];

  Future<List<Reservacion>>? _reservacionesFuture;
  Future<List<Viaje>>? _viajesFuture;
  // List<Reservacion>? _localReservaciones;

  @override
  void initState() {
    super.initState();
    paquete = widget.paquete;
    _reservacionesFuture ??= _cargarReservaciones();
    _viajesFuture ??= _cargarViajes();
    url += paquete.paquId.toString();
  }

  List<Widget> listadoReservaciones(List<dynamic>? info) {
    List<Widget> tempList = [];
    Set<String> uniqueHaCaNombresForRendering = {};

    if (info != null) {
      for (var element in info) {
        if (!uniqueHaCaNombresForRendering.contains(element.haCaNombre)) {
          uniqueHaCaNombresForRendering.add(element.haCaNombre);
          tempList.add(Row(
            children: [
              Expanded(
                child: Text(
                  element.haCaNombre,
                  style: const TextStyle(
                      color: Color(0xFFFFBD59),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Cantidad: ${uniqueHaCaNombres[element.haCaNombre]}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ));
          tempList.add(Row(
            children: [
              Expanded(
                child: Text(
                  element.hoteNombre,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  '${element.ciudDescripcion}, ${element.estaDescripcion}, ${element.paisDescripcion}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ));
          tempList.add(Row(
            children: [
              Expanded(
                child: Text(
                  'Fecha entrada: ${element.reseFechaEntrada.toString().split("T")[0]}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Expanded(
                child: Text(
                  'Precio por noche: L. ${element.resePrecio.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ));
          tempList.add(Row(
            children: [
              Expanded(
                child: Text(
                  'Fecha salida: ${element.reseFechaSalida.toString().split("T")[0]}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Expanded(
                  child: Text(
                '${element.impuDescripcion} (${element.paisPorcentajeImpuesto * 100}%) por noche: \n L. ${(element.resePrecio * element.paisPorcentajeImpuesto).toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ],
          ));
          tempList.add(Row(
            children: [
              const Expanded(
                child: Text(
                  'Total reservación: ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'L. ${((element.resePrecio * uniqueHaCaNombres[element.haCaNombre]) + (element.resePrecio * uniqueHaCaNombres[element.haCaNombre] * element.paisPorcentajeImpuesto)).toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ));
          tempList.add(const Divider());
        }
      }
    }
    return tempList;
  }

  Future<List<Reservacion>> _cargarReservaciones() async {
    List<Reservacion> list = [];
    url =
        "https://etravel.somee.com/API/DetallePorPaquete/Reservaciones/${paquete.paquId}";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> estadosCivilesJson = jsonDecode(respuesta.body);
        list = estadosCivilesJson
            .map((json) => Reservacion.fromJson(json))
            .toList();
        if (list.isNotEmpty) {
          for (var element in list) {
            if (uniqueHaCaNombres.containsKey(element.haCaNombre)) {
              uniqueHaCaNombres[element.haCaNombre] =
                  uniqueHaCaNombres[element.haCaNombre]! + 1;
            } else {
              uniqueHaCaNombres[element.haCaNombre] = 1;
            }
          }
        } else {
          print('Error al cargar los detalles');
        }
      });
    }
    return list;
  }

  List<Widget> listadoViajes(List<dynamic>? info) {
    List<Widget> tempList = [];
    // Set<String> uniqueHaCaNombresForRendering = {};

    if (info != null) {
      for (var element in info) {
        // if (!uniqueHaCaNombresForRendering.contains(element.haCaNombre)) {
        //   uniqueHaCaNombresForRendering.add(element.haCaNombre);
        // }
        tempList.add(Row(
          children: [
            Expanded(
              child: Text(
                element.puntoFinal,
                style: const TextStyle(
                    color: Color(0xFFFFBD59),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Cantidad: ${element.viaj_Cantidad}',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ));
        tempList.add(Row(
          children: [
            Expanded(
              child: Text(
                '${element.estadoFinal}, ${element.paisFinal}',
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                'Precio por boleto: L. ${element.viaj_Precio.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
        tempList.add(Row(
          children: [
            Expanded(
              child: Text(
                'Sale de: ${element.puntoInicio}, ${element.estadoInicio}, ${element.paisInicio}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                '${element.impu_Descripcion} (${element.pais_PorcentajeImpuesto * 100}%) por boleto: \n L. ${(element.viaj_Precio * element.pais_PorcentajeImpuesto).toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
        tempList.add(Row(
          children: [
            Expanded(
              child: Text(
                'Fecha y hora salida: ${element.horT_FechaYhora.toString().split(" ")[0]} ${element.horT_FechaYhora.toString().split(" ")[1]}',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            const Expanded(
                child: Text(
              '',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ],
        ));
        tempList.add(Row(
          children: [
            const Expanded(
              child: Text(
                'Total reservación: ',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'L. ${((element.viaj_Precio * element.viaj_Cantidad) + (element.viaj_Precio * element.viaj_Cantidad * element.pais_PorcentajeImpuesto)).toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
        tempList.add(const Divider());
      }
    }
    return tempList;
  }

  Future<List<Viaje>> _cargarViajes() async {
    List<Viaje> list = [];
    url =
        "https://etravel.somee.com/API/DetallePorPaquete/Viajes/${paquete.paquId}";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> estadosCivilesJson = jsonDecode(respuesta.body);
        list = estadosCivilesJson.map((json) => Viaje.fromJson(json)).toList();
        if (list.isNotEmpty) {
          // for (var element in list) {
          //   if (uniqueHaCaNombres.containsKey(element.haCaNombre)) {
          //     uniqueHaCaNombres[element.haCaNombre] =
          //         uniqueHaCaNombres[element.haCaNombre]! + 1;
          //   } else {
          //     uniqueHaCaNombres[element.haCaNombre] = 1;
          //   }
          // }
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
                    width: 150,
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
        // reverse: true,
        children: [
          Card(
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Reservaciones: ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFBD59),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Layout()));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xFFFFBD59),
                        ),
                        label: const Text("Agregar"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<Reservacion>>(
                    future: _reservacionesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: listadoReservaciones(snapshot.data),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Viajes: ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFBD59),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Transportes()));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xFFFFBD59),
                        ),
                        label: const Text("Agregar"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<Viaje>>(
                    future: _viajesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: listadoViajes(snapshot.data),
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
}
