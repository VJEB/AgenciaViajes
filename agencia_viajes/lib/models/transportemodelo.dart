class TransporteData {
  final String esCiDescripcion;
  final String ciudDescripcion;
  final int numeroPersonas;

  TransporteData({
    required this.esCiDescripcion,
    required this.ciudDescripcion,
    required this.numeroPersonas,
  });

  factory TransporteData.fromJson(Map<String, dynamic> json) {
    return TransporteData(
      esCiDescripcion: json['esCi_Descripcion'],
      ciudDescripcion: json['ciud_Descripcion'],
      numeroPersonas: json['numeroPersonas'],
    );
  }
}