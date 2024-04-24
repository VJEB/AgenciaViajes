class HabitacionCategoria {
  final int haCaId;
  final String hoCaNombre;
  final double haCaPrecioPorNoche;
  final int habiNumCamas;
  final String? foHaUrlImagen;

  HabitacionCategoria({
    required this.haCaId,
    required this.hoCaNombre,
    required this.haCaPrecioPorNoche,
    required this.habiNumCamas,
    this.foHaUrlImagen
  });

  factory HabitacionCategoria.fromJson(Map<String, dynamic> json) {
    return HabitacionCategoria(
      haCaId: json['haCa_Id'],
      hoCaNombre: json['haCa_Nombre'],
      haCaPrecioPorNoche: json['haCa_PrecioPorNoche'],
      habiNumCamas: json['habi_NumCamas'],
      foHaUrlImagen: json['FoHa_UrlImagen'],
    );
  }

  @override
  String toString() {
    return 'Habitacion categoria $hoCaNombre, ID: $haCaId';
  }
}
