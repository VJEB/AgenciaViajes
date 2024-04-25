import 'dart:convert';

import 'package:agencia_viajes/models/habitaciones_categorias.dart';
import 'package:agencia_viajes/models/hotel.dart';
import 'package:agencia_viajes/models/paquete.dart';
import 'package:agencia_viajes/models/reservacion.dart';
import 'package:agencia_viajes/models/service_result.dart';
import 'package:agencia_viajes/screen/paquetes_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/gestures.dart';
// import 'dart:collection';

class HotelScreen extends StatefulWidget {
  final Hotel hotel;
  final List<String> imageUrls;
  final HabitacionCategoria? habitacionCategoria;
  const HotelScreen(
      {required this.hotel,
      this.habitacionCategoria,
      super.key,
      required this.imageUrls});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  final _formKey = GlobalKey<FormState>();

  String persId = 1.toString();

  String urlPaquetes = "https://etravel.somee.com/API/Paquete/ListPaquetes/";

  Hotel get hotel => widget.hotel;
  List<String> get imageUrls => widget.imageUrls;
  late HabitacionCategoria? habitacionCategoria;

  late Paquete _paqueteSeleccionado;
  final List<Paquete> _paquetes = [];

  Future<List<Paquete>>? _paquetesFuture;
  @override
  void initState() {
    super.initState();
    habitacionCategoria = widget.habitacionCategoria;
    _numPersonasHabitacion =
        habitacionCategoria != null ? habitacionCategoria!.habiNumPersonas : 1;
    _numPersonas =
        habitacionCategoria != null ? habitacionCategoria!.habiNumPersonas : 1;
    urlPaquetes += persId;
    _paquetesFuture ??= _cargarPaquetes();
  }

  late int _numPersonasHabitacion;

  int _numHabitaciones = 1;
  late int _numPersonas;

  void _updateHabitaciones() {
    setState(() {
      _numHabitaciones = (_numPersonas / _numPersonasHabitacion).ceil();
    });
  }

  void _updatePersonas() {
    setState(() {
      _numPersonas = _numHabitaciones * _numPersonasHabitacion;
    });
  }

  void _incrementarHabitaciones() {
    setState(() {
      _numHabitaciones++;
      _updatePersonas();
    });
  }

  void _disminuirHabitaciones() {
    setState(() {
      if (_numHabitaciones > 1) {
        _numHabitaciones--;
      }
      _updatePersonas();
    });
  }

  void _incrementarPersonas() {
    setState(() {
      _numPersonas++;
      _updateHabitaciones();
    });
  }

  void _disminuirPersonas() {
    setState(() {
      if (_numPersonas > 1) {
        _numPersonas--;
        _updateHabitaciones();
      }
    });
  }

  void _onPaqueteSelected(Paquete paquete) {
    setState(() {
      _paqueteSeleccionado = paquete;
    });
  }

  Future<List<Paquete>> _cargarPaquetes() async {
    List<Paquete> list = [];
    final respuesta = await http.get(Uri.parse(urlPaquetes));

    if (respuesta.statusCode >= 200 && respuesta.statusCode < 300) {
      setState(() {
        final List<dynamic> paquetesJson = jsonDecode(respuesta.body);
        list = paquetesJson.map((json) => Paquete.fromJson(json)).toList();
        if (list.isNotEmpty) {
          // _estadoSeleccionado = list.first.estaId;
        } else {
          print('Error al cargar los paquetes');
        }
      });
    }
    return list;
  }

  void mostrarDialog(BuildContext context) async {
    DateTime fechaInicio = DateTime.now();
    DateTime fechaFin = DateTime.now().add(const Duration(days: 1));
    int _numNoches =
        fechaFin.difference(fechaInicio).inDays; // Move _numNoches here

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> postReservacion(BuildContext context) async {
              String url =
                  "https://etravel.somee.com/API/DetallePorPaquete/Reservaciones/Create";

              Reservacion reser = Reservacion(
                reseId: 0,
                resePrecio: 0,
                reseCantidad: 0,
                resePrecioTodoIncluido: 0,
                reseFechaEntrada: fechaInicio.toUtc().toIso8601String(),
                reseFechaSalida: fechaFin.toUtc().toIso8601String(),
                reseNumPersonas: _numPersonas,
                reseObservacion: "Observaciones...",
                paquId: _paqueteSeleccionado.paquId,
                haHoId: 0,
                haCaId: habitacionCategoria!.haCaId,
                habitacionesNecesarias: _numHabitaciones,
                habiNumPersonas: habitacionCategoria!.habiNumPersonas,
                reseUsuaCreacion: 1,
                reseFechaCreacion: DateTime.now().toUtc().toIso8601String(),
              );

              var resultado = await http.post(
                Uri.parse(url),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(reser.toJson()),
              );

              if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
                final responseJson = jsonDecode(resultado.body);
                final response = ServiceResult.fromJson(responseJson);
                final mensaje = response.message;
                if (response.code >= 200 && response.code < 300) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PaquetesForm(paquete: _paqueteSeleccionado),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.red[400],
                        content: Text(mensaje)),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Colors.red[400],
                      content: const Text('Error al agregar la reservación.')),
                );
              }
            }

            Future<void> _selectDate(
                BuildContext context, bool modificarFechaInicio) async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: modificarFechaInicio ? fechaInicio : fechaFin,
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
                helpText:
                    'Seleccione la fecha ${modificarFechaInicio ? 'de inicio.' : 'final.'}',
                cancelText: 'Cancelar',
                confirmText: 'Ok',
              );
              if (picked != null &&
                  picked != (modificarFechaInicio ? fechaInicio : fechaFin) &&
                  (!modificarFechaInicio
                      ? picked.isAfter(fechaInicio)
                      : picked.isBefore(fechaFin))) {
                setState(() {
                  if (modificarFechaInicio) {
                    fechaInicio = picked;
                  } else {
                    fechaFin = picked;
                  }
                  // Update _numNoches
                  _numNoches = (fechaFin.difference(fechaInicio).inDays) + 1;
                });
              } else if (picked != null) {
                // Show error message if fechaFin is before fechaInicio
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'La fecha final debe ser después de la fecha de inicio.',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(
                  color: Color(0xC6FFFFFF),
                  width: 0.5,
                ),
              ),
              backgroundColor: const Color(0xC9040000),
              title: const Text(
                'Reservacion',
                style: TextStyle(color: Color(0xFFFFBD59)),
              ),
              content: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  DateDisplayWidget(
                      dateTime: fechaInicio,
                      keyProp: ValueKey(fechaInicio)), // Display fechaInicio
                  ElevatedButton.icon(
                    onPressed: () => _selectDate(context, true),
                    label: const Text(
                      'Fecha inicio',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.calendar_today),
                  ),
                  const SizedBox(height: 10.0),
                  DateDisplayWidget(
                      dateTime: fechaFin,
                      keyProp: ValueKey(fechaFin)), // Display fechaFin
                  ElevatedButton.icon(
                    onPressed: () => _selectDate(context, false),
                    label: const Text(
                      'Fecha fin',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.calendar_today),
                  ),
                  const SizedBox(height: 10.0),
                  FutureBuilder<List<Paquete>>(
                    future: _paquetesFuture, // Use the assigned future
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Cargando...",
                          style: TextStyle(color: Color(0xFFFFBD59)),
                        );
                      } else if (snapshot.hasData) {
                        _paquetes.addAll(snapshot.data as Iterable<Paquete>);
                        return PaquetesDdl(
                            paises: _paquetes,
                            onPaisSelected: _onPaqueteSelected);
                      } else {
                        return const Text(
                          "Error al cargar los paquetes del usuario",
                          style: TextStyle(color: Colors.red),
                        );
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Número de Habitaciones:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$_numHabitaciones',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Número de noches:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$_numNoches',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Precio por Noche:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${habitacionCategoria!.haCaPrecioPorNoche}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${hotel.impuDescripcion} (${hotel.paisPorcentajeImpuesto * 100}%):',
                          style: const TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${((_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches) * hotel.paisPorcentajeImpuesto)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFBD59),
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            color: Color(0xFFFFBD59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'L. ${((_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches) + ((_numHabitaciones * habitacionCategoria!.haCaPrecioPorNoche * _numNoches) * hotel.paisPorcentajeImpuesto))}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    await postReservacion(context);
                                  }
                                },
                                icon: const Icon(Icons.check),
                                label: const Text('Guardar reservación'),
                              ),
                            )
                          ]))
                ]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double kHorizontalPadding = 24;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 1, right: 1),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        'L. ${habitacionCategoria!.haCaPrecioPorNoche.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text(
                        ' / noche',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        '+ L. ${hotel.hotePrecioTodoIncluido.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                          width: 4), // Add some spacing between the texts
                      const Text(
                        ' / todo incluido',
                        style: TextStyle(),
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width:
                    130, // Set width to maximum to make it fill available space
                height: 50, // Set the desired height
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBD59),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Set border radius
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  ),
                  label: const Text("Reservar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black)), // Increase text size
                  icon: const Icon(
                    Icons.book,
                    size: 20,
                    color: Colors.black,
                  ), // Increase icon size
                  onPressed: () {
                    mostrarDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFFFFBD59),
            leading: CircularIconButton(
              iconData: Icons.close,
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconColor: Colors.grey[800],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: PageViewWithIndicators(
                type: IndicatorType.numbered,
                children: imageUrls
                    .map((e) => Hero(
                          tag: e,
                          child: Image.network(
                            e,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              ),
            ),
            expandedHeight: 280,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Habitaciones:",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove,
                                          color: Colors.white),
                                      onPressed: _disminuirHabitaciones,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "$_numHabitaciones",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(Icons.add,
                                          color: Colors.white),
                                      onPressed: _incrementarHabitaciones,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Personas:",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove,
                                          color: Colors.white),
                                      onPressed: _disminuirPersonas,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "$_numPersonas",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(Icons.add,
                                          color: Colors.white),
                                      onPressed: _incrementarPersonas,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const MyDivider(),
                      Text(
                        habitacionCategoria!.hoCaNombre,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: intersperse(
                          const SizedBox(width: 6),
                          [
                            Text(
                              hotel.hoteNombre,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            RatingRow(
                              rating: hotel.hoteEstrellas as double,
                            ),
                          ],
                        ).toList(),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.phone,
                              color:
                                  Color(0xFFFFBD59)), // Icon for phone number
                          const SizedBox(
                              width:
                                  5), // Add some spacing between the icon and text
                          Text(
                            hotel.hoteTelefono.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                              width:
                                  20), // Add some spacing between phone number and email
                          const Icon(Icons.email,
                              color: Color(0xFFFFBD59)), // Icon for email
                          const SizedBox(
                              width:
                                  5), // Add some spacing between the icon and text
                          Text(
                            hotel.hoteCorreo,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        '${hotel.ciudDescripcion}, ${hotel.estaDescripcion}, ${hotel.paisDescripcion}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      const MyDivider(),
                      Text(
                        hotel.hoteResena,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RatingRow extends StatelessWidget {
  const RatingRow({super.key, required this.rating});

  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          size: 20,
          color: Color(0xFFFFBD59),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }
}

class PaquetesDdl extends StatelessWidget {
  final List<Paquete>? paises;
  final Function(Paquete) onPaisSelected;

  const PaquetesDdl(
      {super.key, required this.paises, required this.onPaisSelected});

  @override
  Widget build(BuildContext context) {
    if (paises != null) {
      return Autocomplete<Paquete>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          Set<Paquete> uniqueOptions = {};
          for (var option in paises!) {
            if (option.paquNombre
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase())) {
              uniqueOptions.add(option);
            }
          }
          return uniqueOptions.toList();
        },
        onSelected: (Paquete selection) {
          onPaisSelected(selection);
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<Paquete> onSelected,
            Iterable<Paquete> options) {
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
                    .map((Paquete option) => ListTile(
                          title: Text(
                            option.paquNombre,
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
                return 'Por favor seleccione un paquete';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Paquete',
              labelStyle: TextStyle(color: Color(0xFFFFBD59)),
              hintText: 'Vacaciones Dubai',
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

class DateDisplayWidget extends StatefulWidget {
  final DateTime dateTime;
  final ValueKey keyProp;

  const DateDisplayWidget({
    Key? key,
    required this.dateTime,
    required this.keyProp,
  }) : super(key: key);

  @override
  _DateDisplayWidgetState createState() => _DateDisplayWidgetState();
}

class _DateDisplayWidgetState extends State<DateDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.dateTime.toLocal()}".split(' ')[0],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFBD59),
      ),
    );
  }
}

class CircularIconButton extends StatelessWidget {
  const CircularIconButton(
      {this.iconData,
      this.onPressed,
      this.iconColor = Colors.white,
      this.backgroundColor = Colors.black,
      this.iconSize = 24,
      this.radius = 36,
      super.key});
  final IconData? iconData;
  final Function? onPressed;
  // Defaults to 36. This value should be larger than [iconSize]
  final double radius;
  // Defaults to 24. This value should be smaller than [radius]
  final double iconSize;
  final Color? iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed as void Function()?,
      color: const Color(0xFFFFBD59),
      padding: EdgeInsets.zero,
      splashRadius: 24,
      iconSize: iconSize,
      icon: Container(
        height: radius,
        width: radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Icon(
          iconData,
        ),
      ),
    );
  }
}

enum IndicatorType { dots, numbered }

class PageViewWithIndicators extends StatefulWidget {
  const PageViewWithIndicators(
      {required this.children, this.type = IndicatorType.dots, super.key});
  final List<Widget> children;
  final IndicatorType type;

  @override
  State<PageViewWithIndicators> createState() => _PageViewWithIndicatorsState();
}

class _PageViewWithIndicatorsState extends State<PageViewWithIndicators> {
  late int activeIndex;

  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }

  setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  _buildDottedIndicators() {
    List<Widget> dots = [];
    const double radius = 8;

    for (int i = 0; i < widget.children.length; i++) {
      dots.add(
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                i == activeIndex ? Colors.white : Colors.white.withOpacity(.6),
          ),
        ),
      );
    }
    dots = intersperse(const SizedBox(width: 6), dots)
        .toList(); // Add spacing between dots

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots,
        ),
      ),
    );
  }

  _buildNumberedIndicators() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.33),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Text(
            '${(activeIndex + 1).toString()} / ${widget.children.length.toString()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: setActiveIndex,
          children: widget.children,
        ),
        widget.type == IndicatorType.dots
            ? _buildDottedIndicators()
            : _buildNumberedIndicators(),
      ],
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 48,
      thickness: 1,
    );
  }
}

Iterable<T> intersperse<T>(T element, Iterable<T> iterable) sync* {
  final iterator = iterable.iterator;
  if (iterator.moveNext()) {
    yield iterator.current;
    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}
