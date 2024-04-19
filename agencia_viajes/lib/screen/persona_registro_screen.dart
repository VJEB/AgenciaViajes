// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:agencia_viajes/models/pais.dart';
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
  String? _dni = '',
      _nombre = '',
      _apellido = '',
      _sexo = '',
      _telefono = '',
      _pasaporte = '',
      // ignore: prefer_final_fields
      _esCiId = '',
      _ciudId = '',
      _estadoCivil = '';

  String? _paisSeleccionado;
  List<Pais> _paises = [];

  @override
  void initState() {
    super.initState();
    _cargarPaises();
  }
  
  Future<void> _cargarPaises() async {
    const url = "https://localhost:44372/API/Pais/List";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode >= 200) {
      setState(() {
        final List<dynamic> paisesJson = jsonDecode(respuesta.body);
        _paises = paisesJson.map((json) => Pais.fromJson(json)).toList();
        if (_paises.isNotEmpty) {
          print(_paises[0].paisDescripcion);
          _paisSeleccionado = _paises.first.paisId; 
        }
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor ingrese su número de identidad';
                    }
                    return null;
                  },
                  onSaved: (value) => _dni = value,
                  decoration:
                      const InputDecoration(labelText: 'Número de identidad'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor ingrese su pasaporte';
                    }
                    return null;
                  },
                  onSaved: (value) => _pasaporte = value ?? '',
                  decoration: const InputDecoration(labelText: 'Pasaporte'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor ingrese su nombre';
                    }
                    return null;
                  },
                  onSaved: (value) => _nombre = value ?? '',
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor ingrese su apellido';
                    }
                    return null;
                  },
                  onSaved: (value) => _apellido = value ?? '',
                  decoration: const InputDecoration(labelText: 'Apellido'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor ingrese su teléfono';
                    }
                    return null;
                  },
                  onSaved: (value) => _telefono = value ?? '',
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                ),
                ListTile(
                  title: const Text('Sexo'),
                  subtitle: _sexo == null
                      ? const Text(
                          'Por favor seleccione su sexo',
                          style: TextStyle(
                              color:
                                  Colors.red), // Make the text red for emphasis
                        )
                      : Text(_sexo!), // Display selected gender as subtitle
                  trailing: const Icon(
                      Icons.keyboard_arrow_down), // Optional: Add dropdown icon
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Por favor seleccione su sexo'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                              title: const Text('Femenino'),
                              value: 'F',
                              groupValue: _sexo,
                              onChanged: (value) {
                                setState(() {
                                  _sexo = value;
                                });
                                Navigator.of(context).pop(); // Close dialog
                              },
                            ),
                            RadioListTile(
                              title: const Text('Masculino'),
                              value: 'M',
                              groupValue: _sexo,
                              onChanged: (value) {
                                setState(() {
                                  _sexo = value;
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
                ListTile(
                  title: const Text('Estado civil'),
                  subtitle: _estadoCivil == null
                      ? const Text(
                          'Por favor seleccione su estado civil',
                          style: TextStyle(
                              color:
                                  Colors.red), // Make the text red for emphasis
                        )
                      : Text(
                          _estadoCivil!), // Display selected state as subtitle
                  trailing: const Icon(
                      Icons.keyboard_arrow_down), // Optional: Add dropdown icon
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title:
                            const Text('Por favor seleccione su estado civil'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                              title: const Text('Soltero/a'),
                              value: 'Soltero/a',
                              groupValue: _estadoCivil,
                              onChanged: (value) {
                                setState(() {
                                  _estadoCivil = value;
                                });
                                Navigator.of(context).pop(); // Close dialog
                              },
                            ),
                            RadioListTile(
                              title: const Text('Casado/a'),
                              value: 'Casado/a',
                              groupValue: _estadoCivil,
                              onChanged: (value) {
                                setState(() {
                                  _estadoCivil = value;
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('País'),
                    FutureBuilder<dynamic>(
                      future: _cargarPaises(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return PaisesDdl(paises: _paises);
                        } else {
                          return const Text("Cargando...");
                        }
                      },
                    ),
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor ingrese Ciud_Id';
                    }
                    return null;
                  },
                  onSaved: (value) => _ciudId = value ?? '',
                  decoration: const InputDecoration(labelText: 'Ciudad'),
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
                              if (_sexo == '' || _estadoCivil == '') {
                                // Show validation message for Sexo or Estado Civil
                                setState(() {
                                  _sexo = null;
                                  _estadoCivil = null;
                                });
                              } else {
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
    );
  }
}

// Widget listadoPaises(List<Pais> paises) {
//   // List<Widget> lista = [];
//   // if (paises != null) {
//   //   for (var pais in paises) {
//   //     lista.add(Text(pais.paisDescripcion));
//   //   }
//   // }
//   return Autocomplete<String>(
//     optionsBuilder: (TextEditingValue textEditingValue) {
//       if (textEditingValue.text == '') {
//         return const Iterable<String>.empty();
//       }
//       return paises.where((Pais pais) {
//         return pais.paisDescripcion.contains(textEditingValue.text.toLowerCase());
//       });
//     },
//     onSelected: (String selection) {
//       debugPrint('You just selected $selection');
//     },
//   );
// }

class PaisesDdl extends StatefulWidget {
  final List<Pais> paises;
  const PaisesDdl({super.key, required this.paises});

  @override
  State<PaisesDdl> createState() => _PaisesDdl();
}

class _PaisesDdl extends State<PaisesDdl> {
  @override
  Widget build(BuildContext context) {
    List<String> nombrePaises = widget.paises.map((pais) => pais.paisDescripcion).toList();
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return nombrePaises.where((String pais) {
          return nombrePaises.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}