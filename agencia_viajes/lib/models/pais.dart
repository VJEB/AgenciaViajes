class Pais {
  final String paisId;
  final String paisDescripcion;

  Pais({required this.paisId, required this.paisDescripcion});

  factory Pais.fromJson(Map<String, dynamic> json) {
    return Pais(
      paisId: json['pais_Id'].toString(),
      paisDescripcion: json['pais_Descripcion'],
    );
  }
}