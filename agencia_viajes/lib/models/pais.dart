class Pais {
  final int paisId;
  final String paisDescripcion;
  final int paisUsuaCreacion;
  final String paisFechaCreacion;
  final int? paisUsuaModifica;
  final String? paisFechaModifica;
  final int? impuId;
  final dynamic impu;

  Pais({
    required this.paisId,
    required this.paisDescripcion,
    required this.paisUsuaCreacion,
    required this.paisFechaCreacion,
    this.paisUsuaModifica,
    this.paisFechaModifica,
    this.impuId,
    this.impu,
  });

  @override
  String toString() {
    return paisDescripcion;
  }

  factory Pais.fromJson(Map<String, dynamic> json) {
    return Pais(
      paisId: json['pais_Id'],
      paisDescripcion: json['pais_Descripcion'],
      paisUsuaCreacion: json['pais_Usua_Creacion'],
      paisFechaCreacion: json['pais_Fecha_Creacion'],
      paisUsuaModifica: json['pais_Usua_Modifica'],
      paisFechaModifica: json['pais_Fecha_Modifica'],
      impuId: json['impu_Id'],
      impu: json['impu'],
    );
  }
}
