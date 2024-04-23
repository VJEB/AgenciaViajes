// ignore_for_file: unused_field

import 'dart:convert';

import 'package:agencia_viajes/models/estadoCivil.dart';
import 'package:agencia_viajes/models/persona.dart';
import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/models/pais.dart';
import 'package:agencia_viajes/models/estado.dart';
import 'package:agencia_viajes/models/ciudad.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RegistroPersona extends StatefulWidget {
  const RegistroPersona({super.key});

  @override
  State<RegistroPersona> createState() => _RegistroPersonaState();
}

class _RegistroPersonaState extends State<RegistroPersona> {
  final _formKey = GlobalKey<FormState>();
  // ignore: duplicate_ignore
  // ignore: unused_field
  String _dni = '',
      _pasaporte = '',
      _nombre = '',
      _apellido = '',
      _telefono = '',
      _sexo = '',
      _estadoCivil = '';

  int _estadoCivilSeleccionado = 0;
  final List<EstadoCivil> _estadosCiviles = [];

  int _paisSeleccionado = 0;
  final List<Pais> _paises = [];

  int _estadoSeleccionado = 0;
  final List<Estado> _estados = [];

  int _ciudadSeleccionada = 0;
  final List<Ciudad> _ciudades = [];

  Future<List<EstadoCivil>>? _estadosCivilesFuture;
  Future<List<Pais>>? _paisesFuture;
  Future<List<Estado>>? _estadosFuture;
  Future<List<Ciudad>>? _ciudadesFuture;

  @override
  void initState() {
    super.initState();
    _estadosCivilesFuture ??= _cargarEstadosCiviles();
    _paisesFuture ??= _cargarPaises();
    _paisesFuture?.then((_) {
      _estadosFuture ??= _cargarEstados();
      _estadosFuture?.then((_) {
        _ciudadesFuture ??= _cargarCiudades();
      });
    });
  }

  Future<List<EstadoCivil>> _cargarEstadosCiviles() async {
    List<EstadoCivil> list = [];
    const url = "https://etravel.somee.com/API/EstadoCivil/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> estadosCivilesJson = jsonDecode(respuesta.body);
      list =
          estadosCivilesJson.map((json) => EstadoCivil.fromJson(json)).toList();
      if (list.isNotEmpty) {
        _estadoCivilSeleccionado = list.first.esCiId;
      } else {
        print('Error al cargar los paises');
      }
      // setState(() {
      // });
    }
    return list;
  }

  Future<List<Pais>> _cargarPaises() async {
    List<Pais> list = [];
    const url = "https://etravel.somee.com/API/Pais/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      final List<dynamic> paisesJson = jsonDecode(respuesta.body);
      list = paisesJson.map((json) => Pais.fromJson(json)).toList();
      if (list.isNotEmpty) {
        _paisSeleccionado = list.first.paisId;
      } else {
        print('Error al cargar los paises');
      }
      // setState(() {
      // });
    }
    return list;
  }

  void _onPaisSelected(Pais selectedPais) {
    setState(() {
      _paisSeleccionado = selectedPais.paisId;
      _estados.clear();
    });
    _estadosFuture = _cargarEstados();
  }

  Future<List<Estado>> _cargarEstados() async {
    List<Estado> list = [];
    String url = "https://etravel.somee.com/API/Estado/List/$_paisSeleccionado";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> estadosJson = jsonDecode(respuesta.body);
        list = estadosJson.map((json) => Estado.fromJson(json)).toList();
        if (list.isNotEmpty) {
          _estadoSeleccionado = list.first.estaId;
        } else {
          print('Error al cargar los estados');
        }
      });
    }
    return list;
  }

  void _onEstadoSelected(Estado selectedEstado) {
    setState(() {
      _estadoSeleccionado = selectedEstado.estaId;
      _ciudades.clear();
    });
    _ciudadesFuture = _cargarCiudades();
  }

  Future<List<Ciudad>> _cargarCiudades() async {
    List<Ciudad> list = [];
    String url =
        "https://etravel.somee.com/API/Ciudad/List/$_estadoSeleccionado";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> estadosJson = jsonDecode(respuesta.body);
        list = estadosJson.map((json) => Ciudad.fromJson(json)).toList();
        if (list.isNotEmpty) {
          _estadoSeleccionado = list.first.estaId;
        } else {
          print('Error al cargar las ciudades');
        }
      });
    }
    return list;
  }

  void _onCiudadSelected(Ciudad selectedCiudad) {
    setState(() {
      _ciudadSeleccionada = selectedCiudad.ciudId;
    });
  }

  void guardarPersona(BuildContext context, [bool mounted = true]) async {
    // show the loading dialog
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

    await postPersona();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> postPersona() async {
    const String url = "https://etravel.somee.com/API/Persona/Create";
    Persona persona = Persona(
        persId: 0,
        persDNI: _dni,
        persPasaporte: _pasaporte,
        persNombre: _nombre,
        persApellido: _apellido,
        persTelefono: int.parse(_telefono),
        ciudId: _ciudadSeleccionada,
        persSexo: _sexo,
        esCiId: _estadoCivilSeleccionado,
        persUsuaCreacion: 1,
        persFechaCreacion: DateTime.now().toUtc().toIso8601String());

    var resultado = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(persona.toJson()),
    );

    if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insertado con Éxito')),
      );
      // Navigator.pushNamed(context, '/usuario/registro');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[400],
            content: const Text('Ya existe una persona con esa información')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const InicioSesion()));
          },
        ),
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        reverse: true, // This will make the list view start from the bottom
        children: [
          Card(
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (TextEditingValue oldValue,
                              TextEditingValue newValue) {
                            return RegExp(r'^[a-zA-Z0-9]*$')
                                    .hasMatch(newValue.text)
                                ? newValue
                                : oldValue;
                          },
                        ),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Por favor ingrese su número de identidad';
                        }
                        return null;
                      },
                      onSaved: (value) => _dni = value!,
                      decoration: const InputDecoration(
                        labelText: 'Número de identidad',
                        labelStyle: TextStyle(color: Color(0xFFFFBD59)),
                        hintText: '0501200504202',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (TextEditingValue oldValue,
                              TextEditingValue newValue) {
                            return RegExp(r'^[a-zA-Z0-9]*$')
                                    .hasMatch(newValue.text)
                                ? newValue
                                : oldValue;
                          },
                        ),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Por favor ingrese su pasaporte';
                        }
                        return null;
                      },
                      onSaved: (value) => _pasaporte = value ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Pasaporte',
                        labelStyle: TextStyle(color: Color(0xFFFFBD59)),
                        hintText: 'A05045DA540',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (TextEditingValue oldValue,
                              TextEditingValue newValue) {
                            return RegExp(r'^[a-zA-Z\s]*$')
                                    .hasMatch(newValue.text)
                                ? newValue
                                : oldValue;
                          },
                        ),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Por favor ingrese su nombre';
                        }
                        return null;
                      },
                      onSaved: (value) => _nombre = value ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        labelStyle: TextStyle(color: Color(0xFFFFBD59)),
                        hintText: 'John',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (TextEditingValue oldValue,
                              TextEditingValue newValue) {
                            return RegExp(r'^[a-zA-Z\s]*$')
                                    .hasMatch(newValue.text)
                                ? newValue
                                : oldValue;
                          },
                        ),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Por favor ingrese su apellido';
                        }
                        return null;
                      },
                      onSaved: (value) => _apellido = value ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Apellido',
                        labelStyle: TextStyle(color: Color(0xFFFFBD59)),
                        hintText: 'Doe',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (TextEditingValue oldValue,
                              TextEditingValue newValue) {
                            return RegExp(r'^[0-9]*$').hasMatch(newValue.text)
                                ? newValue
                                : oldValue;
                          },
                        ),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Por favor ingrese su teléfono';
                        }
                        return null;
                      },
                      onSaved: (value) => _telefono = value ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        labelStyle: TextStyle(color: Color(0xFFFFBD59)),
                        hintText: '31466774',
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
                    const SizedBox(height: 20),
                    ListTile(
                      title: const Text(
                        'Sexo',
                        style: TextStyle(color: Color(0xFFFFBD59)),
                      ),
                      subtitle: Text(
                        _sexo,
                        style: const TextStyle(color: Color(0xFFC28427)),
                      ), // Display selected gender as subtitle
                      trailing: const Icon(Icons
                          .keyboard_arrow_down), // Optional: Add dropdown icon
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                color: Color(
                                    0xC6FFFFFF), // You can adjust the color here
                                width: 0.5, // You can adjust the width here
                              ),
                            ),
                            backgroundColor: const Color(0x6A040000),
                            title: const Text(
                              'Por favor seleccione su sexo',
                              style: TextStyle(color: Color(0xFFFFBD59)),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RadioListTile(
                                  title: const Text(
                                    'Femenino',
                                    style: TextStyle(color: Color(0xFFFFBD59)),
                                  ),
                                  value: 'F',
                                  groupValue: _sexo,
                                  onChanged: (value) {
                                    setState(() {
                                      _sexo = value!;
                                    });
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                ),
                                RadioListTile(
                                  title: const Text(
                                    'Masculino',
                                    style: TextStyle(color: Color(0xFFFFBD59)),
                                  ),
                                  value: 'M',
                                  groupValue: _sexo,
                                  onChanged: (value) {
                                    setState(() {
                                      _sexo = value!;
                                    });
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: _estadosCivilesFuture,
                      builder:
                          (context, AsyncSnapshot<List<EstadoCivil>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'Error al cargar los estados civiles',
                              style: TextStyle(color: Color(0xFFFFBD59)),
                            ),
                          );
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'No hay estados civiles',
                              style: TextStyle(color: Color(0xFFFFBD59)),
                            ),
                          );
                        } else {
                          final List<EstadoCivil> estadosCiviles =
                              snapshot.data!;
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                      color: Color(
                                          0xC6FFFFFF), // You can adjust the color here
                                      width:
                                          0.5, // You can adjust the width here
                                    ),
                                  ),
                                  backgroundColor: const Color(0x6A040000),
                                  title: const Text(
                                    'Por favor seleccione su estado civil',
                                    style: TextStyle(color: Color(0xFFFFBD59)),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: estadosCiviles.map((estadoCivil) {
                                      return RadioListTile(
                                        title: Text(
                                          estadoCivil.esCiDescripcion,
                                          style: const TextStyle(
                                              color: Color(0xFFFFBD59)),
                                        ),
                                        value: estadoCivil.esCiId,
                                        groupValue: _estadoCivilSeleccionado,
                                        onChanged: (value) {
                                          setState(() {
                                            _estadoCivilSeleccionado =
                                                value as int;
                                            _estadoCivil =
                                                estadoCivil.esCiDescripcion;
                                          });
                                          Navigator.of(context)
                                              .pop(); // Close dialog
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: const Text(
                                'Seleccione su estado civil',
                                style: TextStyle(color: Color(0xFFFFBD59)),
                              ),
                              subtitle: Text(
                                _estadoCivil,
                                style:
                                    const TextStyle(color: Color(0xFFC28427)),
                              ), // Display selected gender as subtitle
                              trailing: const Icon(Icons.keyboard_arrow_down),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<List<Pais>>(
                      future: _paisesFuture, // Use the assigned future
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            "Cargando...",
                            style: TextStyle(color: Color(0xFFFFBD59)),
                          );
                        } else if (snapshot.hasData) {
                          _paises.addAll(snapshot.data as Iterable<Pais>);
                          return PaisesDdl(
                              paises: _paises, onPaisSelected: _onPaisSelected);
                        } else {
                          return const Text(
                            "Error al cargar los países",
                            style: TextStyle(color: Colors.red),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<List<Estado>>(
                      future:
                          _estadosFuture, // Use the assigned future for estados
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            "Cargando estados...",
                            style: TextStyle(color: Color(0xFFFFBD59)),
                          );
                        } else if (snapshot.hasData) {
                          _estados.addAll(snapshot.data as Iterable<Estado>);
                          return EstadosDdl(
                            estados: _estados,
                            onEstadoSelected: _onEstadoSelected,
                          );
                        } else {
                          return const Text(
                            "Error al cargar los estados",
                            style: TextStyle(color: Colors.red),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<List<Ciudad>>(
                      future:
                          _ciudadesFuture, // Use the assigned future for estados
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            "Cargando ciudades...",
                            style: TextStyle(color: Color(0xFFFFBD59)),
                          );
                        } else if (snapshot.hasData) {
                          _ciudades.addAll(snapshot.data as Iterable<Ciudad>);
                          return CiudadesDdl(
                            ciudades: _ciudades,
                            onCiudadSelected: _onCiudadSelected,
                          );
                        } else {
                          return const Text(
                            "Error al cargar las ciudades",
                            style: TextStyle(color: Colors.red),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 150, // max width of the button
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_sexo.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromRGBO(239, 83, 80, 1),
                                        content: Text(
                                            'Por favor seleccione su sexo.'),
                                      ),
                                    );
                                  }
                                  if (_estadoCivilSeleccionado == 0) {
                                    // Show validation message for Sexo or Estado Civil
                                    if (_sexo.isNotEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor:
                                              Color.fromRGBO(239, 83, 80, 1),
                                          content: Text(
                                              'Por favor seleccione su estado civil.'),
                                        ),
                                      );
                                    }
                                  }
                                  if (_sexo.isNotEmpty &&
                                      _estadoCivilSeleccionado != 0) {
                                    _formKey.currentState!.save();
                                    guardarPersona(context);
                                  }
                                }
                              },
                              icon: const Icon(Icons.arrow_right),
                              label: const Text('Siguiente'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaisesDdl extends StatelessWidget {
  final List<Pais>? paises;
  final Function(Pais) onPaisSelected;

  const PaisesDdl(
      {super.key, required this.paises, required this.onPaisSelected});

  @override
  Widget build(BuildContext context) {
    if (paises != null) {
      return Autocomplete<Pais>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          Set<Pais> uniqueOptions = {};
          for (var option in paises!) {
            if (option.paisDescripcion
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase())) {
              uniqueOptions.add(option);
            }
          }
          return uniqueOptions.toList();
        },
        onSelected: (Pais selection) {
          onPaisSelected(selection);
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<Pais> onSelected, Iterable<Pais> options) {
          return Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: Color(0xC6FFFFFF),
                width: 0.5,
              ),
            ),
            color: const Color(0xDA040000),
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView(
                children: options
                    .map((Pais option) => ListTile(
                          title: Text(
                            option.paisDescripcion,
                            style: const TextStyle(color: Color(0xFFC28427)),
                          ),
                          onTap: () {
                            onSelected(option);
                          },
                        ))
                    .toList(),
              ),
            ),
          );
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            style: const TextStyle(color: Color(0xFFFFBD59)),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Por favor seleccione un país';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'País',
              labelStyle: TextStyle(color: Color(0xFFFFBD59)),
              hintText: 'Honduras',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC28427)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFBD59)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      );
    } else {
      return const Text("Cargando...");
    }
  }
}

class EstadosDdl extends StatelessWidget {
  final List<Estado>? estados;
  final Function(Estado) onEstadoSelected;

  const EstadosDdl(
      {super.key, required this.estados, required this.onEstadoSelected});

  @override
  Widget build(BuildContext context) {
    if (estados != null) {
      return Autocomplete<Estado>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return estados!.where((Estado option) {
            return option.estaDescripcion
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (Estado selection) {
          onEstadoSelected(selection);
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<Estado> onSelected,
            Iterable<Estado> options) {
          return Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: Color(0xC6FFFFFF),
                width: 0.5,
              ),
            ),
            color: const Color(0xDA040000),
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView(
                children: options
                    .map((Estado option) => ListTile(
                          title: Text(
                            option.estaDescripcion,
                            style: const TextStyle(color: Color(0xFFC28427)),
                          ),
                          onTap: () {
                            onSelected(option);
                          },
                        ))
                    .toList(),
              ),
            ),
          );
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            style: const TextStyle(color: Color(0xFFFFBD59)),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Por favor seleccione un estado';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Estado',
              labelStyle: TextStyle(color: Color(0xFFFFBD59)),
              hintText: 'Cortés',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC28427)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFBD59)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      );
    } else {
      return const Text("Cargando...");
    }
  }
}

class CiudadesDdl extends StatelessWidget {
  final List<Ciudad>? ciudades;
  final Function(Ciudad) onCiudadSelected;

  const CiudadesDdl(
      {super.key, required this.ciudades, required this.onCiudadSelected});

  @override
  Widget build(BuildContext context) {
    if (ciudades != null) {
      return Autocomplete<Ciudad>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return ciudades!.where((Ciudad option) {
            return option.ciudDescripcion
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (Ciudad selection) {
          onCiudadSelected(selection);
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<Ciudad> onSelected,
            Iterable<Ciudad> options) {
          return Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: Color(0xC6FFFFFF),
                width: 0.5,
              ),
            ),
            color: const Color(0xDA040000),
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView(
                children: options
                    .map((Ciudad option) => ListTile(
                          title: Text(
                            option.ciudDescripcion,
                            style: const TextStyle(color: Color(0xFFC28427)),
                          ),
                          onTap: () {
                            onSelected(option);
                          },
                        ))
                    .toList(),
              ),
            ),
          );
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            style: const TextStyle(color: Color(0xFFFFBD59)),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Por favor seleccione una ciudad';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Ciudad',
              labelStyle: TextStyle(color: Color(0xFFFFBD59)),
              hintText: 'Tegucigalpa',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC28427)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFBD59)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      );
    } else {
      return const Text("Cargando...");
    }
  }
}
