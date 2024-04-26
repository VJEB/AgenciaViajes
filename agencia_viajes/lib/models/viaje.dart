class Viaje {
  final int viaj_Id;
  final double viaj_Precio;
  final int viaj_Cantidad;
  final int paqu_Id;
  final int horT_Id;
  final int viaj_Usua_Creacion;
  final String viaj_Fecha_Creacion;
  final int? viaj_Usua_Modifica;
  final String? viaj_Fecha_Modifica;
  final String? puntoInicio;
  final String? puntoFinal;
  final String? estadoInicio;
  final String? estadoFinal;
  final String? paisInicio;
  final String? paisFinal;
  final double? pais_PorcentajeImpuesto;
  final String? impu_Descripcion;
  final String? horT_FechaYhora; // Make it nullable

  Viaje({
    required this.viaj_Id,
    required this.viaj_Precio,
    required this.viaj_Cantidad,
    required this.paqu_Id,
    required this.horT_Id,
    required this.viaj_Usua_Creacion,
    required this.viaj_Fecha_Creacion,
    this.viaj_Usua_Modifica,
    this.viaj_Fecha_Modifica,
    this.puntoInicio,
    this.puntoFinal,
    this.estadoInicio,
    this.estadoFinal,
    this.paisInicio,
    this.paisFinal,
    this.pais_PorcentajeImpuesto,
    this.impu_Descripcion,
    this.horT_FechaYhora, // Include it in the constructor
  });

  factory Viaje.fromJson(Map<String, dynamic> json) {
    return Viaje(
      viaj_Id: json['viaj_Id'],
      viaj_Precio: json['viaj_Precio'].toDouble(),
      viaj_Cantidad: json['viaj_Cantidad'],
      paqu_Id: json['paqu_Id'],
      horT_Id: json['horT_Id'],
      viaj_Usua_Creacion: json['viaj_Usua_Creacion'],
      viaj_Fecha_Creacion: json['viaj_Fecha_Creacion'],
      viaj_Usua_Modifica: json['viaj_Usua_Modifica'],
      viaj_Fecha_Modifica: json['viaj_Fecha_Modifica'],
      puntoInicio: json['puntoInicio'],
      puntoFinal: json['puntoFinal'],
      estadoInicio: json['estadoInicio'],
      estadoFinal: json['estadoFinal'],
      paisInicio: json['paisInicio'],
      paisFinal: json['paisFinal'],
      pais_PorcentajeImpuesto: json['pais_PorcentajeImpuesto']
          ?.toDouble(), // Parse to double or null
      impu_Descripcion: json['impu_Descripcion'],
      horT_FechaYhora: json['horT_FechaYhora'], // Assign value or null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'viaj_Id': viaj_Id,
      'viaj_Precio': viaj_Precio,
      'viaj_Cantidad': viaj_Cantidad,
      'paqu_Id': paqu_Id,
      'horT_Id': horT_Id,
      'viaj_Usua_Creacion': viaj_Usua_Creacion,
      'viaj_Fecha_Creacion': viaj_Fecha_Creacion,
      'viaj_Usua_Modifica': viaj_Usua_Modifica,
      'viaj_Fecha_Modifica': viaj_Fecha_Modifica,
      'puntoInicio': puntoInicio,
      'puntoFinal': puntoFinal,
      'estadoInicio': estadoInicio,
      'estadoFinal': estadoFinal,
      'paisInicio': paisInicio,
      'paisFinal': paisFinal,
      'pais_PorcentajeImpuesto': pais_PorcentajeImpuesto,
      'impu_Descripcion': impu_Descripcion,
      'horT_FechaYhora': horT_FechaYhora, // Include it in the JSON output
    };
  }
}
