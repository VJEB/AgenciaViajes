import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class Graficos extends StatefulWidget {
  static const String routeName = '/Graficos';

  const Graficos({Key? key}) : super(key: key);

  @override
  State<Graficos> createState() => _Graficos();
}

class _Graficos extends State<Graficos> {
  String ciudadesTranscurridas =
      "https://etravel.somee.com/API/Transporte/CiudadHospedaje";
  String hotelesReservados =
      "https://etravel.somee.com/API/Hotel/HoteReservados";
  String viajesPorSexo = "https://etravel.somee.com/API/Transporte/SexoViaje";
  String viajesPorEstadoCivil =
      "https://etravel.somee.com/API/Transporte/EstadoViaje";

  late Future<List<Map<String, dynamic>>> _ciudadesData;
  late Future<List<Map<String, dynamic>>> _hotelesData;
  late Future<List<Map<String, dynamic>>> _sexoViajerosData;
  late Future<List<Map<String, dynamic>>> _estadosCivilesViajerosData;

  @override
  void initState() {
    super.initState();
    _ciudadesData = _getListado(ciudadesTranscurridas);
    _hotelesData = _getListado(hotelesReservados);
    _sexoViajerosData = _getListado(viajesPorSexo);
    _estadosCivilesViajerosData = _getListado(viajesPorEstadoCivil);
  }

  Future<List<Map<String, dynamic>>> _getListado(String categori) async {
    final result = await http.get(Uri.parse(categori));
    if (result.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
          jsonDecode(result.body)['data'] as List<dynamic>);
    } else {
      print("Error en el Endpoint");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: 
      Column(
        children: [
          _buildTarjetaGrafico(_ciudadesData, 'Ciudades Más Visitadas'),
          _buildTarjetaGrafico(_hotelesData, 'Hoteles Más Reservados'),
          _buildTarjetaGrafico(_sexoViajerosData, 'Viajes por Sexo'),
          _buildTarjetaGrafico(
              _estadosCivilesViajerosData, 'Viajes por Estado Civil'),
        ],
      ),
    );
  }

  Widget _buildTarjetaGrafico(
      Future<List<Map<String, dynamic>>> data, String titulo) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 20.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              titulo,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 10.0),
            _buildGrafico(data, titulo),
          ],
        ),
      ),
    );
  }

  Widget _buildGrafico(Future<List<Map<String, dynamic>>> data, String titulo) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No hay datos disponibles');
        } else {
          return SizedBox(
            height: 200,
            child: _buildChart(snapshot.data!, titulo),
          );
        }
      },
    );
  }

  Widget _buildChart(List<Map<String, dynamic>> data, String titulo) {
    final List<Color> colores = [
      Color(0xFFFFBD59),
      Color.fromARGB(255, 177, 115, 1),
      Colors.red,
      Colors.grey,
      Colors.red
      // Agrega más colores si lo necesitas
    ];

    List<charts.Series<Map<String, dynamic>, String>> seriesList = [
      charts.Series<Map<String, dynamic>, String>(
        id: titulo,
        data: data,
        domainFn: (datum, _) => datum[titulo == 'Ciudades Más Visitadas'
            ? 'ciud_Descripcion'
            : titulo == 'Hoteles Más Reservados'
                ? 'hote_Nombre'
                : titulo == 'Viajes por Sexo'
                    ? 'pers_Sexo'
                    : 'esCi_Descripcion'] as String,
        measureFn: (datum, _) => datum[titulo == 'Ciudades Más Visitadas'
            ? 'numeroViajes'
            : titulo == 'Hoteles Más Reservados'
                ? 'numeroReservaciones'
                : titulo == 'Viajes por Sexo'
                    ? 'numeroPersonas'
                    : 'numeroPersonas'] as int,
        colorFn: (_, index) {
          final color = colores[index! % colores.length];
          return charts.ColorUtil.fromDartColor(color);
        },
        labelAccessorFn: (datum, _) {
          final sexo = datum[titulo == 'Ciudades Más Visitadas'
              ? 'ciud_Descripcion'
              : titulo == 'Hoteles Más Reservados'
                  ? 'hote_Nombre'
                  : titulo == 'Viajes por Sexo'
                      ? 'pers_Sexo'
                      : 'esCi_Descripcion'] as String;
          if (sexo == 'M') {
            return 'Masculino: ${datum[titulo == 'Ciudades Más Visitadas' ? 'numeroViajes' : titulo == 'Hoteles Más Reservados' ? 'numeroReservaciones' : titulo == 'Viajes por Sexo' ? 'numeroPersonas' : 'numeroPersonas']}';
          } else if (sexo == 'F') {
            return 'Femenino: ${datum[titulo == 'Ciudades Más Visitadas' ? 'numeroViajes' : titulo == 'Hoteles Más Reservados' ? 'numeroReservaciones' : titulo == 'Viajes por Sexo' ? 'numeroPersonas' : 'numeroPersonas']}';
          } else {
            return ': ${datum[titulo == 'Ciudades Más Visitadas' ? 'numeroViajes' : titulo == 'Hoteles Más Reservados' ? 'numeroReservaciones' : titulo == 'Viajes por Sexo' ? 'numeroPersonas' : 'numeroPersonas']}';
          }
        },
      ),
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
  }
}
