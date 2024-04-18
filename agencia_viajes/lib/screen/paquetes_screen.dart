import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String url = "https://api.thecatapi.com/v1/categories";

  Future<dynamic> _getListado() async {
    final result = await http.get(Uri.parse(url));
    if (result.statusCode >= 200) {
      return jsonDecode(result.body);
    } else {
      print("Error en el endPoint");
      // return const Center(child: Text("Error en el endPoint"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paquetes"),
      ),
      body: FutureBuilder<dynamic>(
        future: _getListado(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: listadoPaquetes(snapshot.data),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> listadoPaquetes(List<dynamic>? info) {
    List<Widget> lista = [];
    if (info != null) {
      for (var element in info) {
        lista.add(Text(element["name"]));
      }
    }
    return lista;
  }
}
