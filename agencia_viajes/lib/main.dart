import 'package:agencia_viajes/models/hotel.dart';
import 'package:agencia_viajes/models/place.dart';
import 'package:agencia_viajes/models/profile.dart';
import 'package:agencia_viajes/screen/hotel_screen.dart';
import 'package:agencia_viajes/screen/usuario_registro_screen.dart';
import 'package:flutter/material.dart';
import 'screen/layout.dart';
// import 'screen/persona_registro_screen.dart';
// import 'screen/iniciosesion_screen.dart';
// import 'screen/usuarios_screen1.dart';
// import 'screen/usuarios_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agencia Viajes',
      debugShowCheckedModeBanner: false,
      home: HotelScreen(
        hotel: Hotel(
            hoteId: 1,
            hoteNombre: "Hotel",
            hoteDireccionExacta: "Direccion",
            hotePrecioTodoIncluido: 200,
            haHoPrecioPorNoche: 500,
            hoteEstrellas: 5,
            ciudId: "ciudId",
            ciudDescripcion: "DescripcionCiud",
            estaDescripcion: "DescripcionEsta",
            hoteEstado: 1,
            hoteFechaCreacion: "FechaCreacion",
            hoteHoraSalida: "HoraSalida",
            hoteImagen: "https://cdn2.thecatapi.com/images/b9r.jpg",
            hoteUsuaCreacion: 1,
            paisDescripcion: "pais"),
        place: const Place(
            address: "adress",
            bathCount: 5,
            bedCount: 5,
            bedroomCount: 5,
            city: "city",
            costPerNight: 500,
            country: "country",
            guestCount: 50,
            imageUrls: [
              "https://cdn2.thecatapi.com/images/3ql.jpg",
              "https://cdn2.thecatapi.com/images/9p2.jpg",
              "https://cdn2.thecatapi.com/images/b9r.jpg"
            ],
            numberOfRatings: 500,
            owner: Profile(
              isSuperhost: true,
              name: "owner",
              profileImageUrl: "profileImageUrl",
            ),
            rating: 5,
            state: "state",
            title: "title",
            type: PlaceType.apartment,
            zipcode: "zipcode",
            description: "description"),
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFBD59))
            .copyWith(background: Colors.black),
      ),
      routes: {
        '/inicio': (context) => const Layout(),
        '/register': (context) => const RegistroUsuario(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
