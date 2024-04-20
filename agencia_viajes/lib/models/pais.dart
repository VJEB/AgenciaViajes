class Pais {
  final int paisId;
  final String paisDescripcion;
  final int paisUsuaCreacion;
  final String paisFechaCreacion;
  final int? paisUsuaModifica;
  final String? paisFechaModifica;
  final dynamic paisUsuaCreacionNavigation;
  final dynamic paisUsuaModificaNavigation;
  final List<dynamic> tbEstados;

  Pais({
    required this.paisId,
    required this.paisDescripcion,
    required this.paisUsuaCreacion,
    required this.paisFechaCreacion,
    this.paisUsuaModifica,
    this.paisFechaModifica,
    this.paisUsuaCreacionNavigation,
    this.paisUsuaModificaNavigation,
    required this.tbEstados,
  });

  factory Pais.fromJson(Map<String, dynamic> json) {
    return Pais(
      paisId: json['pais_Id'],
      paisDescripcion: json['pais_Descripcion'],
      paisUsuaCreacion: json['pais_Usua_Creacion'],
      paisFechaCreacion: json['pais_Fecha_Creacion'],
      paisUsuaModifica: json['pais_Usua_Modifica'],
      paisFechaModifica: json['pais_Fecha_Modifica'],
      paisUsuaCreacionNavigation: json['pais_Usua_CreacionNavigation'],
      paisUsuaModificaNavigation: json['pais_Usua_ModificaNavigation'],
      tbEstados: List<dynamic>.from(json['tbEstados'] ?? []),
    );
  }
}
