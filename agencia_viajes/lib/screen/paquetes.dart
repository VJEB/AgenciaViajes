import 'dart:convert';
import 'package:agencia_viajes/models/paquete.dart';
import 'package:agencia_viajes/models/service_result.dart';
import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'package:agencia_viajes/screen/paquetes_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:agencia_viajes/screen/carrito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paquetes extends StatefulWidget {
  const Paquetes({super.key});

  @override
  State<Paquetes> createState() => _PaquetesState();
}

class _PaquetesState extends State<Paquetes> {
  final _formKey = GlobalKey<FormState>();

  String persId = 1.toString();

  String url = "https://etravel.somee.com/API/Paquete/ListPaquetes/";
  List<dynamic> carrito = [];
  String _paquNombre = "";

  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error en el endPoint");
      // return const Center(child: Text("Error en el endPoint"));
    }
  }

  // String _paqueteSeleccionado = '';

  final List<Paquete> _paquetes = [];
  Future<List<Paquete>>? _paquetesFuture;

  @override
  void initState() {
    super.initState();
    url += persId;
    _paquetesFuture ??= _cargarPaquetes();
    _cargarCarrito();
  }

  Future<List<Paquete>> _cargarPaquetes() async {
    List<Paquete> list = [];
    final respuesta = await http.get(Uri.parse(url));

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

  void _cargarCarrito() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final carritoJson = prefs.getString('carrito');
    if (carritoJson != null) {
      setState(() {
        carrito = jsonDecode(carritoJson);
      });
    }
  }

  void crearPaquete(BuildContext context, [bool mounted = true]) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Color(0xC6FFFFFF),
            width: 0.5,
          ),
        ),
        backgroundColor: const Color(0xC9040000),
        title: const Text(
          'Nuevo paquete',
          style: TextStyle(color: Color(0xFFFFBD59)),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
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
                onSaved: (value) => _paquNombre = value ?? '',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150, // max width of the button
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            bool response;
                            Paquete paqu;
                            (response, paqu) = await postPaquete();
                            if (response) {
                              if (!mounted) return;
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PaquetesForm(
                                          paquete: paqu,
                                        )),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red[400],
                                    content: const Text(
                                        'Ya existe un paquete con ese nombre')),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Guardar'),
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
  }

  Future<(bool, Paquete)> postPaquete() async {
    const String url = "https://localhost:44372/API/Paquete/Create";
    Paquete paquete = Paquete(
        paquId: 0,
        paquNombre: _paquNombre,
        paquPrecio: 0,
        paquEstado: 0,
        paquUsuaCreacion: 1,
        paquFechaCreacion: DateTime.now().toUtc().toIso8601String(),
        persId: 1);

    var resultado = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(paquete.toJson()),
    );

    if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
      setState(() {
        final responseJson = jsonDecode(resultado.body);
        final response =
            ServiceResult.fromJson(responseJson); // Parsing the whole response
        if (response.code >= 200 && response.code < 300) {
          paquete.paquId = int.parse(response.message);
        } else {
          print('Error al cargar los estados');
        }
      });
      return (true, paquete);
    }
    return (false, paquete);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paquetes",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
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
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      drawer: MenuLateral(
        context: context,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 20),
            FutureBuilder<dynamic>(
              future: _paquetesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return CarouselPaquetes(
                      listadoPaquetes: snapshot.data,
                      agregarAlCarrito: _agregarAlCarrito,
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),

            // FutureBuilder<dynamic>(
            //   future: _getListado(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return CarouselWithHoteles(
            //           listadoHoteles: snapshot.data,
            //           agregarAlCarrito: _agregarAlCarrito);
            //     } else {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //   },
            // ),
            Expanded(
              child: FutureBuilder<List<Paquete>>(
                future: _paquetesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(top: 15),
                            color: Colors.white10,
                            clipBehavior: Clip.hardEdge,
                            child: InkWell(
                              splashColor:
                                  const Color.fromARGB(255, 255, 239, 120)
                                      .withAlpha(30),
                              onTap: () {
                                _mostrarDetalles(
                                    context, snapshot.data![index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data![index].paquNombre,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFFFFBD59),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _agregarAlCarrito(
                                                snapshot.data![index]);
                                          },
                                          child: const Text('Agregar'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total: L.${snapshot.data![index].paquPrecio}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        PaquetesForm(
                                                          paquete: snapshot
                                                              .data![index],
                                                        )));
                                          },
                                          child: const Text('Editar'),
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
                      return const Center(child: Text('No data available'));
                    }
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
          crearPaquete(context);
        },
        backgroundColor: const Color(0xFFFFBD59),
        child: const Icon(Icons.add, color: Colors.black),
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
          title: const Text('Detalles del Paquete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nombre: ${hotel["paqu_Nombre"]}'),
                Text('Total: L.${hotel["paqu_Precio"]}'),
                // Agrega más detalles aquí si es necesario
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarCarrito(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const Carrito()));
  }
}

class CarouselPaquetes extends StatelessWidget {
  final List<Paquete>? listadoPaquetes;
  final Function(dynamic) agregarAlCarrito;

  const CarouselPaquetes(
      {super.key, this.listadoPaquetes, required this.agregarAlCarrito});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: listadoPaquetes!.map<Widget>((paque) {
        return Card(
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paque.paquNombre,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFBD59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: L.${paque.paquPrecio}',
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
                      agregarAlCarrito(paque);
                    },
                    child: const Text('Agregar'),
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
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInBack,
      ),
    );
  }
}
