class FacturaDetalle {
  final int fdetId;
  final int factId;
  final int paquId;
  final int factCantidadPaqu;
  final double? fdetSubTotal;
  final double? fdetTotal;
  final double? fdetImpuesto;

  FacturaDetalle({
    required this.fdetId,
    required this.factId,
    required this.paquId,
    required this.factCantidadPaqu,
    required this.fdetSubTotal,
    required this.fdetTotal,
    required this.fdetImpuesto,
  });

  factory FacturaDetalle.fromJson(Map<String, dynamic> json) {
    return FacturaDetalle(
      fdetId: json['fdet_Id'],
      factId: json['fact_Id'],
      paquId: json['paqu_Id'],
      factCantidadPaqu: json['fact_CantidadPaqu'],
      fdetSubTotal: json['fdet_SubTotal'] as double,
      fdetTotal: json['fdet_Total'] as double,
      fdetImpuesto: json['fdet_Impuesto'] as double,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fdet_Id': fdetId,
      'fact_Id': factId,
      'paqu_Id': paquId,
      'fact_CantidadPaqu': factCantidadPaqu,
      'fdet_SubTotal': fdetSubTotal,
      'fdet_Total': fdetTotal,
      'fdet_Impuesto': fdetImpuesto,
    };
  }
}
