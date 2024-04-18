import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatCategoriesDataTable extends StatefulWidget {
  @override
  _CatCategoriesDataTableState createState() => _CatCategoriesDataTableState();
}

class _CatCategoriesDataTableState extends State<CatCategoriesDataTable> {
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
    final response =
        await http.get(Uri.parse("https://localhost:44372/API/Usuario/List"));
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
        title: Text('Cat Categories'),
      ),
      body: FutureBuilder(
        future: _fetchData,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> categories = _sortCategories(snapshot.data!);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 150,
                headingTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                dataRowHeight: 60,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('Codigo'),
                    onSort: (columnIndex, _) {
                      _sortData('usua_Id');
                    },
                  ),
                  DataColumn(
                    label: Text('Usuario'),
                    onSort: (columnIndex, _) {
                      _sortData('usua_Usuario');
                    },
                  ),
                  DataColumn(
                    label: Text('Admin'),
                  ),
                  DataColumn(
                    label: Text('Persona'),
                  ),
                  DataColumn(
                    label: Text('Rol'),
                  ),
                  DataColumn(
                    label: Text('Acciones'),
                  ),
                ],
                rows: categories.map((category) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(category['usua_Id'].toString())),
                      DataCell(Text(category['usua_Usuario'])),
                      DataCell(Text(category['usua_Admin'].toString())),
                      DataCell(Text(category['persona'] != null
                          ? category['persona']
                          : '')),
                      DataCell(Text(category['rol_Descripcion'] != null
                          ? category['rol_Descripcion']
                          : '')),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.details),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
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
    );
  }
}
