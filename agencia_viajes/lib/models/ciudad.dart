class Ciudad {
  final int ciudId;
  final String ciudCodigo;
  final String ciudDescripcion;
  final int estaId;
  final int ciudUsuaCreacion;
  final String ciudFechaCreacion;
  final int? ciudUsuaModifica;
  final String? ciudFechaModifica;

  Ciudad({
    required this.ciudId,
    required this.ciudCodigo,
    required this.ciudDescripcion,
    required this.estaId,
    required this.ciudUsuaCreacion,
    required this.ciudFechaCreacion,
    this.ciudUsuaModifica,
    this.ciudFechaModifica,
  });

  @override
  String toString() {
    return ciudDescripcion;
  }

  factory Ciudad.fromJson(Map<String, dynamic> json) {
    return Ciudad(
      ciudId: json['ciud_Id'],
      ciudCodigo: json['ciud_Codigo'], // Updated to include ciudCodigo
      ciudDescripcion: json['ciud_Descripcion'],
      estaId: json['esta_Id'],
      ciudUsuaCreacion: json['ciud_Usua_Creacion'],
      ciudFechaCreacion: json['ciud_Fecha_Creacion'],
      ciudUsuaModifica: json['ciud_Usua_Modifica'],
      ciudFechaModifica: json['ciud_Fecha_Modifica'],
    );
  }
}
