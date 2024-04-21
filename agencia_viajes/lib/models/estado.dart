class Estado {
  final String estaId;
  final String estaDescripcion;
  final int estaUsuaCreacion;
  final String estaFechaCreacion;
  final int? estaUsuaModifica;
  final String? estaFechaModifica;

  Estado({
    required this.estaId,
    required this.estaDescripcion,
    required this.estaUsuaCreacion,
    required this.estaFechaCreacion,
    this.estaUsuaModifica,
    this.estaFechaModifica,
  });

  @override
  String toString() {
    return estaDescripcion;
  }

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      estaId: json['esta_Id'],
      estaDescripcion: json['esta_Descripcion'],
      estaUsuaCreacion: json['esta_Usua_Creacion'],
      estaFechaCreacion: json['esta_Fecha_Creacion'],
      estaUsuaModifica: json['esta_Usua_Modifica'],
      estaFechaModifica: json['esta_Fecha_Modifica'],
    );
  }
}
