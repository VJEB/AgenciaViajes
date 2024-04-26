import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:agencia_viajes/screen/componentes/menu_lateral.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/models/usuario.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
 
  late UsuarioModel _usuario =
     UsuarioModel(usuaId: -1, persId: -1);

    
String url = "";
  //  String url2 = "30";

@override
  void initState() {
    super.initState();
    _loadUsuario(); // Llama a la función para cargar los datos del usuario al iniciar la pantalla
  }

  Future<void> _loadUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final int? usuaId = prefs.getInt('usua_Id');
    final int? persId = prefs.getInt('pers_Id');
    final String? usuaUsuario = prefs.getString('usua_Usuario');
    final String? usuaContra = prefs.getString('usua_Contra');


    if (usuaId != null && usuaUsuario != null && usuaContra != null && persId != null) {
      setState(() {
        _usuario = UsuarioModel(
          usuaId: usuaId,
          persId: persId,
          usuaUsuario: usuaUsuario,
          usuaContra: usuaContra,
         
        );
          url = "https://localhost:44372/API/Factura/List/${_usuario.persId}";
      });
        _getListado();
    } else {
    
    }
  }

  // Método que obtiene la lista de datos de la API
  Future<dynamic> _getListado() async {
    // Realiza una solicitud HTTP GET a la URL de la API
    final respuesta = await http.get(Uri.parse(url));
    
    // Verifica si la respuesta tiene un código de estado 200 (éxito)
    if (respuesta.statusCode == 200){
      // Si la respuesta es exitosa, decodifica el cuerpo JSON y lo devuelve
      return jsonDecode(respuesta.body);
    } else {
      // Si hay un error en la respuesta, imprime un mensaje de error
      print("Error con la respuesta");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facturas", style: TextStyle(color: Color(0xFFFFBD59)),),
         backgroundColor: Colors.black,
         iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
     drawer: MenuLateral(
        //      context: context,
        // usuario: UsuarioModel(usuaId: -1),
      ),
      body: FutureBuilder<dynamic>(
        future: _getListado(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            // Si hay datos en el snapshot, muestra la lista de elementos
            return ListView.builder(
              itemCount: _groupedData(snapshot.data!).length,
              itemBuilder: (context, index) {
                // Agrupar facturas por ID
                return _buildCard(_groupedData(snapshot.data!)[index]);
              },
            );
          } else {
            // Si no hay datos en el snapshot, muestra un indicador de carga
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

    List<dynamic> _groupedData(List<dynamic> data) {
    // Agrupar datos por ID de factura
    Map<int, List<dynamic>> groupedData = {};
    data.forEach((item) {
      int facturaId = item["fact_Id"];
      if (!groupedData.containsKey(facturaId)) {
        groupedData[facturaId] = [];
      }
      groupedData[facturaId]!.add(item);
    });
    return groupedData.values.toList();
  }


 Widget _buildCard(List<dynamic> facturaDetails) {
    // Obtener los datos de la factura
    int facturaId = facturaDetails.first["fact_Id"];
    String fecha = facturaDetails.first["fact_Fecha"];
    fecha = fecha.replaceAll("T18:", "\nHora: ");
    String metodoPago = facturaDetails.first["meto_Descripcion"];

    // Calcular subtotal, impuesto y total combinados de todos los detalles de compra
    double subtotal = 0;
    double impuesto = 0;
    double total = 0;
    facturaDetails.forEach((detalle) {
      subtotal += double.parse(detalle["fdet_SubTotal"]);
      impuesto += double.parse(detalle["fdet_Impuesto"]);
      total += double.parse(detalle["fdet_Total"]);
    });

    return Card(
      color: Colors.white10,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Factura #${facturaId.toString()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text("Método de pago:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            Text("$metodoPago", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFBD59)),),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fecha: $fecha", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            Text("Detalle de la compra:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: facturaDetails.map
               ((detalle) {
                  String nombrePaquete = detalle["paqu_Nombre"];
                  double precioPaquete = double.parse(detalle["paqu_Precio"]);
                  int cantidad = int.parse(detalle["fact_CantidadPaqu"]);
                  return Text("$cantidad x $nombrePaquete: \$${(precioPaquete * cantidad).toStringAsFixed(2)}", style: TextStyle(color: Color(0xFFFFBD59), fontWeight:FontWeight.bold ),);
                }).toList()
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Subtotal: \$${subtotal.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Text("Impuesto: \$${impuesto.toStringAsFixed(2)}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Total: \$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

