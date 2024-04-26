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
  String categoriUtilerias =
      "http://gestioneventooooss.somee.com/API/Evento/ListUtileriasMasCompradas";
  String categoriPaquetes =
      "http://gestioneventooooss.somee.com/API/Evento/ListPaquetesMasSolicitados";
  String categoriEventos =
      "http://gestioneventooooss.somee.com/API/Evento/ListMayorEventos_Mostrar";
  String categoriEventosPorSexo =
      "http://gestioneventooooss.somee.com/API/Evento/ListMayorEventosPorSexo_Mostrar";

  late Future<List<Map<String, dynamic>>> _utileriasData;
  late Future<List<Map<String, dynamic>>> _paquetesData;
  late Future<List<Map<String, dynamic>>> _eventosData;
  late Future<List<Map<String, dynamic>>> _eventosPorSexoData;

  @override
  void initState() {
    super.initState();
    _utileriasData = _getListado(categoriUtilerias);
    _paquetesData = _getListado(categoriPaquetes);
    _eventosData = _getListado(categoriEventos);
    _eventosPorSexoData = _getListado(categoriEventosPorSexo);
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
      child: Column(
        children: [
          _buildTarjetaGrafico(_utileriasData, 'Utilerías Más Compradas'),
          _buildTarjetaGrafico(_paquetesData, 'Paquetes Más Solicitados'),
          _buildTarjetaGrafico(_eventosData, 'Mayores Eventos'),
          _buildTarjetaGrafico(_eventosPorSexoData, 'Mayores Eventos por Sexo'),
        ],
      ),
    );
  }

  Widget _buildTarjetaGrafico(
      Future<List<Map<String, dynamic>>> data, String titulo) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              titulo,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow,
      // Agrega más colores si lo necesitas
    ];

    List<charts.Series<Map<String, dynamic>, String>> seriesList = [
      charts.Series<Map<String, dynamic>, String>(
        id: titulo,
        data: data,
        domainFn: (datum, _) => datum[titulo == 'Utilerías Más Compradas'
            ? 'nombreUtileria'
            : titulo == 'Paquetes Más Solicitados'
                ? 'nombrePaquete'
                : titulo == 'Mayores Eventos'
                    ? 'ever_Descripcion'
                    : 'even_Sexo'] as String,
        measureFn: (datum, _) => datum[titulo == 'Utilerías Más Compradas'
            ? 'totalCompras'
            : titulo == 'Paquetes Más Solicitados'
                ? 'totalPaquetesSolicitados'
                : titulo == 'Mayores Eventos'
                    ? 'totalEventos'
                    : 'totalEventosEve'] as int,
        colorFn: (_, index) {
          final color = colores[index! % colores.length];
          return charts.ColorUtil.fromDartColor(color);
        },
        labelAccessorFn: (datum, _) {
          final sexo = datum[titulo == 'Utilerías Más Compradas'
              ? 'nombreUtileria'
              : titulo == 'Paquetes Más Solicitados'
                  ? 'nombrePaquete'
                  : titulo == 'Mayores Eventos'
                      ? 'ever_Descripcion'
                      : 'even_Sexo'] as String;
          if (sexo == 'M') {
            return 'Masculino: ${datum[titulo == 'Utilerías Más Compradas' ? 'totalCompras' : titulo == 'Paquetes Más Solicitados' ? 'totalPaquetesSolicitados' : titulo == 'Mayores Eventos' ? 'totalEventos' : 'totalEventosEve']}';
          } else if (sexo == 'F') {
            return 'Femenino: ${datum[titulo == 'Utilerías Más Compradas' ? 'totalCompras' : titulo == 'Paquetes Más Solicitados' ? 'totalPaquetesSolicitados' : titulo == 'Mayores Eventos' ? 'totalEventos' : 'totalEventosEve']}';
          } else {
            return ': ${datum[titulo == 'Utilerías Más Compradas' ? 'totalCompras' : titulo == 'Paquetes Más Solicitados' ? 'totalPaquetesSolicitados' : titulo == 'Mayores Eventos' ? 'totalEventos' : 'totalEventosEve']}';
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