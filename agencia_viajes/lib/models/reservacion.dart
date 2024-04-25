class Reservacion {
  final int reseId;
  final double resePrecio;
  final int reseCantidad;
  final double resePrecioTodoIncluido;
  final String reseFechaEntrada;
  final String reseFechaSalida;
  final int reseNumPersonas;
  final String reseObservacion;
  final int paquId;
  final int haHoId;
  final int? haCaId;
  final int? habitacionesNecesarias;
  final int? habiNumPersonas;
  final int reseUsuaCreacion;
  final String reseFechaCreacion;
  final int? reseUsuaModifica;
  final String? reseFechaModifica;

  Reservacion({
    required this.reseId,
    required this.resePrecio,
    required this.reseCantidad,
    required this.resePrecioTodoIncluido,
    required this.reseFechaEntrada,
    required this.reseFechaSalida,
    required this.reseNumPersonas,
    required this.reseObservacion,
    required this.paquId,
    required this.haHoId,
    this.haCaId,
    this.habitacionesNecesarias,
    this.habiNumPersonas,
    required this.reseUsuaCreacion,
    required this.reseFechaCreacion,
    this.reseUsuaModifica,
    this.reseFechaModifica,
  });

  factory Reservacion.fromJson(Map<String, dynamic> json) {
    return Reservacion(
      reseId: json['rese_Id'],
      resePrecio: json['rese_Precio'].toDouble(),
      reseCantidad: json['rese_Cantidad'],
      resePrecioTodoIncluido: json['rese_PrecioTodoIncluido'].toDouble(),
      reseFechaEntrada: json['rese_FechaEntrada'],
      reseFechaSalida: json['rese_FechaSalida'],
      reseNumPersonas: json['rese_NumPersonas'],
      reseObservacion: json['rese_Observacion'],
      paquId: json['paqu_Id'],
      haHoId: json['haHo_Id'],
      haCaId: json['haCa_Id'],
      habitacionesNecesarias: json['habitacionesNecesarias'],
      habiNumPersonas: json['habi_NumPersonas'],
      reseUsuaCreacion: json['rese_Usua_Creacion'],
      reseFechaCreacion: json['rese_Fecha_Creacion'],
      reseUsuaModifica: json['rese_Usua_Modifica'],
      reseFechaModifica: json['rese_Fecha_Modifica'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rese_Id': reseId,
      'rese_Precio': resePrecio,
      'rese_Cantidad': reseCantidad,
      'rese_PrecioTodoIncluido': resePrecioTodoIncluido,
      'rese_FechaEntrada': reseFechaEntrada,
      'rese_FechaSalida': reseFechaSalida,
      'rese_NumPersonas': reseNumPersonas,
      'rese_Observacion': reseObservacion,
      'paqu_Id': paquId,
      'haHo_Id': haHoId,
      'haCa_Id': haCaId,
      'habitacionesNecesarias': habitacionesNecesarias,
      'habi_NumPersonas': habiNumPersonas,
      'rese_Usua_Creacion': reseUsuaCreacion,
      'rese_Fecha_Creacion': reseFechaCreacion,
      'rese_Usua_Modifica': reseUsuaModifica,
      'rese_Fecha_Modifica': reseFechaModifica,
    };
  }
}
