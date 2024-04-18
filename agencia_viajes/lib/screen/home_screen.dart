import 'dart:convert';

import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url =
      "https://api.thecatapi.com/v1/images/search?limit=10&api_key=live_svNggot0QuFvpCKGlKx5JCR3riTy1FAfV15cqsWY5apGugXQYgsLyt2B2wFBG8ln";

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFFFFBD59).withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.black,
            title:
                const Text("Index", style: TextStyle(color: Color(0xFFFFBD59))),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.login),
                tooltip: 'Iniciar sesión',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const InicioSesion()));
                },
              ),
            ],
            iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
          ),
        ),
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
        lista.add(
          Card(
            color: Colors.white10,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor:
                  const Color.fromARGB(255, 255, 239, 120).withAlpha(30),
              onTap: () {
                debugPrint('Card tapped.');
              },
              child: SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        element["url"],
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ID: ${element["id"]}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Desde: L.${element["width"]}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 44, 214, 50),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  '*****',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 30),
                                Text(
                                  'Estrellas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Direccion',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ciudad',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Pais',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
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
          ),
        );
      }
    }
    return lista;
  }
}
