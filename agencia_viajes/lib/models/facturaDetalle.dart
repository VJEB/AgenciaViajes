class FacturaDetalle {
  final int fdetId;
  final int factId;
  final int paquId;
  final int factCantidadPaqu;
  final double fdetSubTotal;
  final double fdetTotal;
  final double fdetImpuesto;

  FacturaDetalle({
    required this.fdetId,
    required this.factId,
    required this.paquId,
    required this.factCantidadPaqu,
    required this.fdetSubTotal,
    required this.fdetTotal,
    required this.fdetImpuesto,
  });

  Map<String, dynamic> toJson() {
    return {
      'fdet_Id': fdetId,
      'fact_Id': factId,
      'paqu_Id': paquId,
      'fact_CantidadPaqu': factCantidadPaqu,
      'fdet_SubTotal': fdetSubTotal.toDouble(),
      'fdet_Total': fdetTotal.toDouble(),
      'fdet_Impuesto': fdetImpuesto.toDouble(),
    };
  }
}
