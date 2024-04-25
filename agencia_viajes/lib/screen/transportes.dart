import 'dart:convert';
import 'package:agencia_viajes/models/paquete.dart';
import 'package:agencia_viajes/models/service_result.dart';
import 'package:agencia_viajes/screen/hotel_screen.dart';
import 'package:agencia_viajes/screen/paquetes_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'package:http/http.dart' as http;
import 'package:agencia_viajes/models/pais.dart';
import 'package:agencia_viajes/models/estado.dart';
import 'package:agencia_viajes/models/ciudad.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Transportes extends StatefulWidget {
  const Transportes({Key? key});

  @override
  State<Transportes> createState() => _TransportesState();
}

class _TransportesState extends State<Transportes> {
  final _formKey = GlobalKey<FormState>();

  String url = "https://etravel.somee.com/API/Transporte/TransporteList/2";

  String persId = 1.toString();

  String urlPaquetes = "https://etravel.somee.com/API/Paquete/ListPaquetes/";

  Map<int, bool> expansionState = {};

  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error en el endPoint");
      // return const Center(child: Text("Error en el endPoint"));
    }
  }

  // Variables para almacenar las selecciones de los filtros
  int? _paisSeleccionado;
  int? _estadoSeleccionado;
  int? _ciudadSeleccionada;

  // Variables para almacenar los datos de los dropdown lists de países, estados y ciudades
  List<Pais> _paises = [];
  List<Estado> _estados = [];
  List<Ciudad> _ciudades = [];
  List<dynamic> _transportes = [];

  // Funciones para obtener los datos de los dropdown lists de países, estados y ciudades
  Future<void> _cargarPaises() async {
    const url = "https://etravel.somee.com/API/Pais/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> paisesJson = jsonDecode(respuesta.body);
      setState(() {
        _paises = paisesJson.map((json) => Pais.fromJson(json)).toList();
      });
    } else {
      print('Error al cargar los países');
    }
  }

  Future<void> _cargarEstados(int paisId) async {
    String url = "https://etravel.somee.com/API/Estado/List/$paisId";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> estadosJson = jsonDecode(respuesta.body);
      setState(() {
        _estados = estadosJson.map((json) => Estado.fromJson(json)).toList();
      });
    } else {
      print('Error al cargar los estados');
    }
  }

  // Función para cargar la lista de transportes
  Future<void> _cargarTransportes(int ciudadId) async {
    String url =
        "https://etravel.somee.com/API/Transporte/TransporteList/$ciudadId";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> transportesJson = jsonDecode(respuesta.body);
      setState(() {
        _transportes = transportesJson;
      });
    } else {
      print('Error al cargar los transportes');
    }
  }

  Future<void> _cargarCiudades(int estadoId) async {
    String url = "https://etravel.somee.com/API/Ciudad/List/$estadoId";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> ciudadesJson = jsonDecode(respuesta.body);
      setState(() {
        _ciudades = ciudadesJson.map((json) => Ciudad.fromJson(json)).toList();
      });
    } else {
      print('Error al cargar las ciudades');
    }
  }

  late Paquete _paqueteSeleccionado;
  final List<Paquete> _paquetes = [];

  Future<List<Paquete>>? _paquetesFuture;

  void _onPaqueteSelected(Paquete paquete) {
    setState(() {
      _paqueteSeleccionado = paquete;
    });
  }

  Future<List<Paquete>> _cargarPaquetes() async {
    List<Paquete> list = [];
    final respuesta = await http.get(Uri.parse(urlPaquetes));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> paquetesJson = jsonDecode(respuesta.body);
        list = paquetesJson.map((json) => Paquete.fromJson(json)).toList();
        if (list.isNotEmpty) {
          // _estadoSeleccionado = list.first.estaId;
        } else {
          print('Error al cargar los paquetes');
        }
      });
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _cargarPaises();
    urlPaquetes += persId;
    _paquetesFuture ??= _cargarPaquetes();
  }

  void mostrarDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> postReservacion(BuildContext context) async {
              String url =
                  "https://etravel.somee.com/API/DetallePorPaquete/Viajes/Create";

              // Viaje viaje = Viaje();

              var resultado = await http.post(
                Uri.parse(url),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(viaje.toJson()),
              );

              if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
                final responseJson = jsonDecode(resultado.body);
                final response = ServiceResult.fromJson(responseJson);
                final mensaje = response.message;
                if (response.code >= 200 && response.code < 300) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PaquetesForm(paquete: _paqueteSeleccionado),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.red[400],
                        content: Text(mensaje)),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Colors.red[400],
                      content: const Text('Error al agregar la reservación.')),
                );
              }
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(
                  color: Color(0xC6FFFFFF),
                  width: 0.5,
                ),
              ),
              backgroundColor: const Color(0xC9040000),
              title: const Text(
                'Boletos',
                style: TextStyle(color: Color(0xFFFFBD59)),
              ),
              content: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 10.0),
                  FutureBuilder<List<Paquete>>(
                    future: _paquetesFuture, // Use the assigned future
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Cargando...",
                          style: TextStyle(color: Color(0xFFFFBD59)),
                        );
                      } else if (snapshot.hasData) {
                        _paquetes.addAll(snapshot.data as Iterable<Paquete>);
                        return PaquetesDdl(
                            paises: _paquetes,
                            onPaisSelected: _onPaqueteSelected);
                      } else {
                        return const Text(
                          "Error al cargar los paquetes del usuario",
                          style: TextStyle(color: Colors.red),
                        );
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Precio por Boleto:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${""}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${hotel.impuDescripcion} (${hotel.paisPorcentajeImpuesto * 100}%):',
                          style: const TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${((_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches) * hotel.paisPorcentajeImpuesto)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${((_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches) + ((_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches) * hotel.paisPorcentajeImpuesto))}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 150, // max width of the button
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    await postReservacion(context);
                                  }
                                },
                                icon: const Icon(Icons.check),
                                label: const Text('Guardar reservación'),
                              ),
                            )
                          ]))
                ]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transportes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      drawer: MenuLateral(
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildFiltroButton(),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.white10,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildDropdown(
                      labelText: 'Pais',
                      value: _paisSeleccionado,
                      items: _paises.map((pais) {
                        return DropdownMenuItem<int>(
                          value: pais.paisId,
                          child: Text(pais.paisDescripcion,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _paisSeleccionado = newValue;
                          _estadoSeleccionado = null;
                          _ciudadSeleccionada = null;
                          _estados.clear();
                          _ciudades.clear();
                          _cargarEstados(newValue!);
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    _buildDropdown(
                      labelText: 'Estado',
                      value: _estadoSeleccionado,
                      items: _estados.map((estado) {
                        return DropdownMenuItem<int>(
                          value: estado.estaId,
                          child: Text(estado.estaDescripcion,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _estadoSeleccionado = newValue;
                          _ciudadSeleccionada = null;
                          _ciudades.clear();
                        });
                        _cargarCiudades(newValue!);
                      },
                    ),
                    SizedBox(height: 8),
                    _buildDropdown(
                      labelText: 'Ciudad',
                      value: _ciudadSeleccionada,
                      items: _ciudades.map((ciudad) {
                        return DropdownMenuItem<int>(
                          value: ciudad.ciudId,
                          child: Text(ciudad.ciudDescripcion,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _ciudadSeleccionada = newValue;
                          _cargarTransportes(newValue!);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _transportes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white10,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {},
                      splashColor: const Color.fromARGB(255, 255, 239, 120)
                          .withAlpha(30),
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 1,
                                child: CachedNetworkImage(
                                  imageUrl: _transportes[index]
                                      ["ciud_UrlImagen"],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            _transportes[index]
                                                    ["horT_FechaYhora"]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFFFBD59),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // 'Desde: L.${element["haHo_PrecioPorNoche"]}',
                                          'L.${_transportes[index]["tran_Precio"].toString()}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 44, 214, 50),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Inicio: ${_transportes[index]["puntoInicio"]}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Destino: ${_transportes[index]["puntoFinal"]}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFFFFBD59),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Transporte: ${_transportes[index]["tiTr_Descripcion"]}',
                                              style: const TextStyle(
                                                fontSize: 13,
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
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltroButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Filtros', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildDropdown({
    required String labelText,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required void Function(int?)? onChanged,
  }) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xFFFFBD59)),
        border: OutlineInputBorder(),
      ),
      value: value,
      onChanged: onChanged,
      items: items,
    );
  }

  Widget _buildField(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFBD59),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
