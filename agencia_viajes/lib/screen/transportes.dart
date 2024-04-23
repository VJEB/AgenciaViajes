import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'package:http/http.dart' as http;
import 'package:agencia_viajes/models/pais.dart';
import 'package:agencia_viajes/models/estado.dart';
import 'package:agencia_viajes/models/ciudad.dart';

class Transportes extends StatefulWidget {
  const Transportes({Key? key});

  @override
  State<Transportes> createState() => _TransportesState();
}

class _TransportesState extends State<Transportes> {
  String url = "https://etravel.somee.com/API/Transporte/TransporteList/2";
  
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
    String url = "https://etravel.somee.com/API/Transporte/TransporteList/$ciudadId";
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

  @override
  void initState() {
    super.initState();
    _cargarPaises();
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
            child: _buildFiltroButton(), // Agregar el botón de filtro
          ),

            Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.white10, // Cambio de color de la tarjeta
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
                          child: Text(pais.paisDescripcion, style: TextStyle(color: Colors.white)),
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
                          child: Text(estado.estaDescripcion, style: TextStyle(color: Colors.white)),
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
                          child: Text(ciudad.ciudDescripcion, style: TextStyle(color: Colors.white)),
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
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField('Precio:', _transportes[index]["tran_Precio"]),
                          _buildField('Horario:', _transportes[index]["horT_FechaYhora"]),
                          _buildField('Descripción:', _transportes[index]["tiTr_Descripcion"]),
                          _buildField('Destino:', _transportes[index]["puntoFinal"]),
                        ],
                      ),
                      onTap: () {
                        // Agregar acción para cuando se presione en un transporte
                      },
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
      onPressed: (){
        
      },
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
