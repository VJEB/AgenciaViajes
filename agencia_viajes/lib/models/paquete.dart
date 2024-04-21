class Paquete {
  int paquId;
  final String paquNombre;
  final int persId;
  final int paquUsuaCreacion;
  final String paquFechaCreacion;
  final int? paquUsuaModifica;
  final String? paquFechaModifica;
  final double? paquPrecio;
  final int? paquEstado;

  Paquete({
    required this.paquId,
    required this.paquNombre,
    required this.persId,
    required this.paquUsuaCreacion,
    required this.paquFechaCreacion,
    this.paquUsuaModifica,
    this.paquFechaModifica,
    this.paquPrecio,
    this.paquEstado,
  });

  factory Paquete.fromJson(Map<String, dynamic> json) {
    return Paquete(
      paquId: json['paqu_Id'],
      paquNombre: json['paqu_Nombre'],
      persId: json['pers_Id'],
      paquUsuaCreacion: json['paqu_Usua_Creacion'],
      paquFechaCreacion: json['paqu_Fecha_Creacion'],
      paquUsuaModifica: json['paqu_Usua_Modifica'],
      paquFechaModifica: json['paqu_Fecha_Modifica'],
      paquPrecio: json['paqu_Precio'].toDouble(),
      paquEstado: json['paqu_Estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paqu_Id': paquId,
      'paqu_Nombre': paquNombre,
      'pers_Id': persId,
      'paqu_Usua_Creacion': paquUsuaCreacion,
      'paqu_Fecha_Creacion': paquFechaCreacion,
      'paqu_Usua_Modifica': paquUsuaModifica,
      'paqu_Fecha_Modifica': paquFechaModifica,
      'paqu_Precio': paquPrecio,
      'paqu_Estado': paquEstado,
    };
  }

  @override
  String toString() {
    return paquNombre;
  }
}
