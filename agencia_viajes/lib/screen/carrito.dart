import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<dynamic> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCatCategories();
  }

  Future<void> _fetchCatCategories() async {
    final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/categories'));
    if (response.statusCode == 200) {
      setState(() {
        _categories = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      _categories[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Precio: \$${_categories[index]['id'].toDouble().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        // Aquí puedes agregar la lógica para mostrar más detalles del producto
                      },
                    ),
                  ),
                  if (_categories[index]['description'] != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        _categories[index]['description'],
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.payment),
                        onPressed: () {
                          // Aquí puedes agregar la lógica para finalizar la compra del producto
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Aquí puedes agregar la lógica para eliminar el producto del carrito
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: 400',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para finalizar toda la compra
                },
                child: Text('Finalizar Compra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


