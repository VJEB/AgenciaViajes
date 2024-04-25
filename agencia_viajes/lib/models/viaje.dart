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

  Viaje({
    required this.viaj_Id,
    required this.viaj_Precio,
    required this.viaj_Cantidad,
    required this.paqu_Id,
    required this.horT_Id,
    required this.viaj_Usua_Creacion,
    required this.viaj_Fecha_Creacion,
    this.viaj_Usua_Modifica,
    this.viaj_Fecha_Modifica
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
    };
  }
}
