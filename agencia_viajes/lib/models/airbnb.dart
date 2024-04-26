class Airbnb {
  final int airbId;
  final String airbNombre;
  final String airbDireccionExacta;
  final double airbPrecioTodoIncluido;
  final double? airbPrecio;
  final int? airbNumCamas;
  final String? airbResena;
  final String? airbCorreo;
  final int? airbTelefono;
  final int? airbNumHabitaciones;
  final String airbImagen;
  final String ciudId;
  final int? airbUsuaCreacion;
  final String? airbFechaCreacion;
  final int? airbUsuaModifica;
  final String? airbFechaModifica;
  final bool? airbEstado;

  Airbnb({
    required this.airbId,
    required this.airbNombre,
    required this.airbDireccionExacta,
    required this.airbPrecioTodoIncluido,
    this.airbPrecio,
    this.airbNumCamas,
    this.airbResena,
    this.airbCorreo,
    this.airbTelefono,
    this.airbNumHabitaciones,
    required this.airbImagen,
    required this.ciudId,
    this.airbUsuaCreacion,
    this.airbFechaCreacion,
    this.airbUsuaModifica,
    this.airbFechaModifica,
    this.airbEstado,
  });

  factory Airbnb.fromJson(Map<String, dynamic> json) {
    return Airbnb(
      airbId: json['airb_Id'],
      airbNombre: json['airb_Nombre'],
      airbDireccionExacta: json['airb_DireccionExacta'],
      airbPrecioTodoIncluido: json['airb_PrecioTodoIncluido'].toDouble(),
      airbPrecio: json['airb_Precio']?.toDouble(),
      airbNumCamas: json['airb_NumCamas'],
      airbResena: json['airb_Resena'],
      airbCorreo: json['airb_Correo'],
      airbTelefono: json['airb_Telefono'],
      airbNumHabitaciones: json['airb_NumHabitaciones'],
      airbImagen: json['airb_Imagen'],
      ciudId: json['ciud_Id'],
      airbUsuaCreacion: json['airb_Usua_Creacion'],
      airbFechaCreacion: json['airb_Fecha_Creacion'],
      airbUsuaModifica: json['airb_Usua_Modifica'],
      airbFechaModifica: json['airb_Fecha_Modifica'],
      airbEstado: json['airb_Estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airb_Id': airbId,
      'airb_Nombre': airbNombre,
      'airb_DireccionExacta': airbDireccionExacta,
      'airb_PrecioTodoIncluido': airbPrecioTodoIncluido,
      'airb_Precio': airbPrecio,
      'airb_NumCamas': airbNumCamas,
      'airb_Resena': airbResena,
      'airb_Correo': airbCorreo,
      'airb_Telefono': airbTelefono,
      'airb_NumHabitaciones': airbNumHabitaciones,
      'airb_Imagen': airbImagen,
      'ciud_Id': ciudId,
      'airb_Usua_Creacion': airbUsuaCreacion,
      'airb_Fecha_Creacion': airbFechaCreacion,
      'airb_Usua_Modifica': airbUsuaModifica,
      'airb_Fecha_Modifica': airbFechaModifica,
      'airb_Estado': airbEstado,
    };
  }

  @override
  String toString() {
    return 'Airbnb: $airbNombre, ID: $airbId';
  }
}
