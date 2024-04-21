class DetalleDePaquete {
  final int dePaId;
  final int haHoTranId;
  final double dePaPrecio;
  final int paquId;
  final int dePaUsuaCreacion;
  final String dePaFechaCreacion;
  final int? dePaUsuaModifica;
  final String? dePaFechaModifica;
  final int dePaCantidad;
  final int dePaNumNoches;
  final double dePaPrecioTodoIncluido;

  DetalleDePaquete({
    required this.dePaId,
    required this.haHoTranId,
    required this.dePaPrecio,
    required this.paquId,
    required this.dePaUsuaCreacion,
    required this.dePaFechaCreacion,
    this.dePaUsuaModifica,
    this.dePaFechaModifica,
    required this.dePaCantidad,
    required this.dePaNumNoches,
    required this.dePaPrecioTodoIncluido,
  });

  factory DetalleDePaquete.fromJson(Map<String, dynamic> json) {
    return DetalleDePaquete(
      dePaId: json['dePa_Id'],
      haHoTranId: json['haHo_Tran_Id'],
      dePaPrecio: json['dePa_Precio'].toDouble(),
      paquId: json['paqu_Id'],
      dePaUsuaCreacion: json['dePa_Usua_Creacion'],
      dePaFechaCreacion: json['dePa_Fecha_Creacion'],
      dePaUsuaModifica: json['dePa_Usua_Modifica'],
      dePaFechaModifica: json['dePa_Fecha_Modifica'],
      dePaCantidad: json['dePa_Cantidad'],
      dePaNumNoches: json['dePa_NumNoches'],
      dePaPrecioTodoIncluido: json['dePa_PrecioTodoIncluido'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dePa_Id': dePaId,
      'haHo_Tran_Id': haHoTranId,
      'dePa_Precio': dePaPrecio,
      'paqu_Id': paquId,
      'dePa_Usua_Creacion': dePaUsuaCreacion,
      'dePa_Fecha_Creacion': dePaFechaCreacion,
      'dePa_Usua_Modifica': dePaUsuaModifica,
      'dePa_Fecha_Modifica': dePaFechaModifica,
      'dePa_Cantidad': dePaCantidad,
      'dePa_NumNoches': dePaNumNoches,
      'dePa_PrecioTodoIncluido': dePaPrecioTodoIncluido,
    };
  }

  @override
  String toString() {
    return 'Detalle Paquete: $dePaId, Paquete ID: $paquId';
  }
}
