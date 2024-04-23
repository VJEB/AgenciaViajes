import 'dart:convert';
import 'package:agencia_viajes/screen/persona_registro_screen.dart';
import 'package:agencia_viajes/screen/usuario_registro_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'package:http/http.dart' as http;

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  late Future<List<dynamic>> _fetchData;
  late String _sortColumn;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _fetchData = _fetchCatCategories();
    _sortColumn = 'usua_Id';
  }

  Future<List<dynamic>> _fetchCatCategories() async {
    final response = await http.get(Uri.parse("https://etravel.somee.com/API/Usuario/List"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load cat categories');
    }
  }

  void _sortData(String column) {
    if (_sortColumn == column) {
      setState(() {
        _sortAscending = !_sortAscending;
      });
    } else {
      setState(() {
        _sortColumn = column;
        _sortAscending = true;
      });
    }
  }

  List<dynamic> _sortCategories(List<dynamic> categories) {
    categories.sort((a, b) {
      if (_sortAscending) {
        return a[_sortColumn].compareTo(b[_sortColumn]);
      } else {
        return b[_sortColumn].compareTo(a[_sortColumn]);
      }
    });
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Usuarios",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      drawer: MenuLateral(
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistroPersona()), // Reemplaza NuevaPantalla con el nombre de la pantalla de destino
                );
              },
              icon: const Icon(Icons.add, color: Colors.black), // Color del icono
              label: const Text(
                'Nuevo',
                style: TextStyle(color: Colors.black), // Color del texto
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBD59), // Color de fondo del botón
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Ajuste del padding horizontal
              ),
            ),
            const SizedBox(height: 8), // Espacio entre el botón y la tabla
            Card(
              color: Colors.white10, // Color de fondo de la tarjeta
              child: FutureBuilder(
                future: _fetchData,
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<dynamic> categories = _sortCategories(snapshot.data!);
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 150,
                        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFFFBD59)), // Estilo del encabezado de la tabla
                        dataRowMaxHeight: 60,
                        columns: <DataColumn>[
                          DataColumn(
                            label: const Text('Codigo', style: TextStyle(color: Colors.white)), // Estilo del texto de la columna
                            onSort: (columnIndex, _) {
                              _sortData('usua_Id');
                            },
                          ),
                          DataColumn(
                            label: const Text('Usuario', style: TextStyle(color: Colors.white)), // Estilo del texto de la columna
                            onSort: (columnIndex, _) {
                              _sortData('usua_Usuario');
                            },
                          ),
                          const DataColumn(
                            label: Text('Admin', style: TextStyle(color: Colors.white)), // Estilo del texto de la columna
                          ),
                          const DataColumn(
                            label: Text('Persona', style: TextStyle(color: Colors.white)), // Estilo del texto de la columna
                          ),
                          const DataColumn(
                            label: Text('Rol', style: TextStyle(color: Colors.white)), // Estilo del texto de la columna
                          ),
                          const DataColumn(
                            label: Center(child: Text('Acciones', style: TextStyle(color: Colors.white))), // Título de acciones centrado
                          ),
                        ],
                        rows: categories.map((category) {
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(Text(category['usua_Id'].toString(), style: const TextStyle(color: Color(0xFFFFBD59)))), // Estilo del texto de la celda
                              DataCell(Text(category['usua_Usuario'], style: const TextStyle(color: Color(0xFFFFBD59)))), // Estilo del texto de la celda
                              DataCell(Text(category['usua_Admin'].toString(), style: const TextStyle(color: Color(0xFFFFBD59)))), // Estilo del texto de la celda
                              DataCell(Text( category['persona'] ?? '', style: const TextStyle(color: Color(0xFFFFBD59)))), // Estilo del texto de la celda
                              DataCell(Text(category['rol_Descripcion'] ?? '', style: const TextStyle(color: Color(0xFFFFBD59)))), // Estilo del texto de la celda
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: const Color(0xFFFFBD59),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.details),
                                    color: const Color(0xFFFFBD59),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: const Color(0xFFFFBD59),
                                    onPressed: () {},
                                  ),
                                ],
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
