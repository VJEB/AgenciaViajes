class EstadoCivil {
  final int esCiId;
  final String esCiDescripcion;
  final int esCiUsuaCreacion;
  final String esCiFechaCreacion;
  final int? esCiUsuaModifica;
  final String? esCiFechaModifica;

  EstadoCivil({
    required this.esCiId,
    required this.esCiDescripcion,
    required this.esCiUsuaCreacion,
    required this.esCiFechaCreacion,
    this.esCiUsuaModifica,
    this.esCiFechaModifica,
  });

  factory EstadoCivil.fromJson(Map<String, dynamic> json) {
    return EstadoCivil(
      esCiId: json['esCi_Id'],
      esCiDescripcion: json['esCi_Descripcion'],
      esCiUsuaCreacion: json['esCi_Usua_Creacion'],
      esCiFechaCreacion: json['esCi_Fecha_Creacion'],
      esCiUsuaModifica: json['esCi_Usua_Modifica'],
      esCiFechaModifica: json['esCi_Fecha_Modifica'],
    );
  }

  @override
  String toString() {
    return esCiDescripcion;
  }
}
