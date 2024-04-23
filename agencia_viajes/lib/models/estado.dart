class Estado {
  final int estaId;
  final String estaCodigo;
  final String estaDescripcion;
  final int estaUsuaCreacion;
  final String estaFechaCreacion;
  final int? estaUsuaModifica;
  final String? estaFechaModifica;
  final int paisId;
  final dynamic estaUsuaCreacionNavigation;
  final dynamic estaUsuaModificaNavigation;
  final dynamic pais;

  Estado({
    required this.estaId,
    required this.estaCodigo,
    required this.estaDescripcion,
    required this.estaUsuaCreacion,
    required this.estaFechaCreacion,
    this.estaUsuaModifica,
    this.estaFechaModifica,
    required this.paisId,
    this.estaUsuaCreacionNavigation,
    this.estaUsuaModificaNavigation,
    this.pais,
  });

  @override
  String toString() {
    return estaDescripcion;
  }

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      estaId: json['esta_Id'],
      estaCodigo: json['esta_Codigo'],
      estaDescripcion: json['esta_Descripcion'],
      estaUsuaCreacion: json['esta_Usua_Creacion'],
      estaFechaCreacion: json['esta_Fecha_Creacion'],
      estaUsuaModifica: json['esta_Usua_Modifica'],
      estaFechaModifica: json['esta_Fecha_Modifica'],
      paisId: json['pais_Id'],
      estaUsuaCreacionNavigation: json['esta_Usua_CreacionNavigation'],
      estaUsuaModificaNavigation: json['esta_Usua_ModificaNavigation'],
      pais: json['pais'],
    );
  }
}
