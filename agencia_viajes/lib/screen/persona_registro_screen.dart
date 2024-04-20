// ignore_for_file: unused_field

import 'dart:convert';

import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/models/pais.dart';
import 'package:flutter/widgets.dart';
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
      _nombre = '',
      _apellido = '',
      _sexo = '',
      _telefono = '',
      _pasaporte = '',
      // ignore: prefer_final_fields
      _esCiId = '',
      _ciudId = '',
      _estadoCivil = '';

  int _paisSeleccionado = 0;
  final List<Pais> _paises = [];

  @override
  void initState() {
    super.initState();
    _cargarPaises();
  }

  Future<List<Pais>> _cargarPaises() async {
    List<Pais> list = [];
    const url = "https://etravel.somee.com/API/Pais/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200) {
      setState(() {
        final List<dynamic> paisesJson = jsonDecode(respuesta.body);
        list = paisesJson.map((json) => Pais.fromJson(json)).toList();
        if (list.isNotEmpty) {
          _paisSeleccionado = list.first.paisId;
        } else {
          print('Error al cargar los paises');
        }
      });
    }
    return list;
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
                        hintText: '0501200504202', // Hint text
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC28427)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFBD59)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
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
                        hintText: 'A05045DA540', // Hint text
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC28427)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFBD59)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
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
                        hintText: 'John', // Hint text
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC28427)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFBD59)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
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
                        hintText: 'Doe', // Hint text
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC28427)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFBD59)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
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
                        hintText: '31466774', // Hint text
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC28427)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFBD59)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
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
                    ListTile(
                      title: const Text(
                        'Estado civil',
                        style: TextStyle(color: Color(0xFFFFBD59)),
                      ),
                      subtitle: Text(
                        _estadoCivil,
                        style: const TextStyle(color: Color(0xFFC28427)),
                      ), // Display selected state as subtitle
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
                              'Por favor seleccione su estado civil',
                              style: TextStyle(color: Color(0xFFFFBD59)),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RadioListTile(
                                  title: const Text('Soltero/a',
                                      style:
                                          TextStyle(color: Color(0xFFFFBD59))),
                                  value: 'Soltero/a',
                                  groupValue: _estadoCivil,
                                  onChanged: (value) {
                                    setState(() {
                                      _estadoCivil = value!;
                                    });
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                ),
                                RadioListTile(
                                  title: const Text('Casado/a',
                                      style:
                                          TextStyle(color: Color(0xFFFFBD59))),
                                  value: 'Casado/a',
                                  groupValue: _estadoCivil,
                                  onChanged: (value) {
                                    setState(() {
                                      _estadoCivil = value!;
                                    });
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                ),
                                // Add more radio options for different civil statuses
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<List<Pais>>(
                      future: _cargarPaises(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return PaisesDdl(paises: snapshot.data);
                        } else {
                          return const Text(
                            "Cargando...",
                            style: TextStyle(color: Color(0xFFFFBD59)),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFFFBD59)),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Por favor ingrese Ciud_Id';
                        }
                        return null;
                      },
                      onSaved: (value) => _ciudId = value ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Ciudad',
                        labelStyle: TextStyle(color: Color(0xFFFFBD59)),
                        hintText: 'San Pedro Sula', // Hint text
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC28427)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFBD59)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .red), // Border color when focused and in error state
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_sexo.isEmpty) {
                                    // Show validation message for Sexo or Estado Civil
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromRGBO(239, 83, 80, 1),
                                        content: Text(
                                            'Por favor seleccione su sexo.'),
                                      ),
                                    );
                                  }
                                  if (_estadoCivil.isEmpty) {
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
                                      _estadoCivil.isNotEmpty) {
                                    _formKey.currentState!.save();
                                    // Call your database insert function here with the form data
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

  const PaisesDdl({super.key, required this.paises});

  @override
  Widget build(BuildContext context) {
    List<String> nombrePaises =
        paises!.map((pais) => pais.paisDescripcion).toList();
    if (paises != null) {
      return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return nombrePaises.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: Color(0xC6FFFFFF), // You can adjust the color here
                width: 0.5, // You can adjust the width here
              ),
            ),
            color: const Color(0xDA040000),
            elevation: 4.0, // Add elevation to the list
            child: SizedBox(
              height: 200.0, // Set a fixed height for the list
              child: ListView(
                children: options
                    .map((String option) => ListTile(
                          title: Text(
                            option,
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
            // onSaved: (value) => _ciudId = value ?? '',
            decoration: const InputDecoration(
              labelText: 'País',
              labelStyle: TextStyle(color: Color(0xFFFFBD59)),
              hintText: 'Honduras', // Hint text
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC28427)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ), // Border color when focused and in error state
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFBD59)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ), // Border color when focused and in error state
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
