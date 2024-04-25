class Factura {
  int factId;
  String factFecha;
  final int metoId;
  final int pagoId;
  final int persId; 
  final int? factUsuaCreacion;
  final String? factFechaCreacion;
  final int? factUsuaModifica;
  final String? factFechaModifica;

  Factura({
    required this.factId,
    required this.factFecha,
    required this.metoId,
    required this.pagoId,
    required this.persId,
    this.factUsuaCreacion,
    this.factFechaCreacion,
    this.factUsuaModifica,
    this.factFechaModifica,
  });

  factory Factura.fromJson(Map<String, dynamic> json) {
    return Factura(
      factId: json['fact_Id'],
      factFecha: json['fact_Fecha'],
      metoId: json['meto_Id'],
      pagoId: json['pago_Id'],
      persId: json['pers_Id'],
      factUsuaCreacion: json['fact_Usua_Creacion'],
      factFechaCreacion: json['fact_Fecha_Creacion'],
      factUsuaModifica: json['fact_Usua_Modifica'],
      factFechaModifica: json['fact_Fecha_Modifica'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fact_Id': factId,
      'fact_Fecha': factFecha,
      'meto_Id': metoId,
      'pago_Id': pagoId,
      'pers_Id': persId,
      'fact_Usua_Creacion': factUsuaCreacion,
      'fact_Fecha_Creacion': factFechaCreacion,
      'fact_Usua_Modifica': factUsuaModifica,
      'fact_Fecha_Modifica': factFechaModifica,
    };
  }

  @override
  String toString() {
    return factFecha;
  }
}
