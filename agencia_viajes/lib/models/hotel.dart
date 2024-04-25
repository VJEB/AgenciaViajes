class Hotel {
  final int hoteId;
  final String hoteNombre;
  final String hoteDireccionExacta;
  final String hoteHoraSalida;
  final double hotePrecioTodoIncluido;
  final int hoteEstrellas;
  final String hoteImagen;
  final int ciudId;
  final String ciudDescripcion;
  final String estaDescripcion;
  final String paisDescripcion;
  final double haHoPrecioPorNoche;
  final int hoteUsuaCreacion;
  final String hoteFechaCreacion;
  final int? hoteUsuaModifica;
  final String? hoteFechaModifica;
  final int hoteEstado;
  final int hoteTelefono;
  final String hoteCorreo;
  final String hoteResena;
  final double paisPorcentajeImpuesto;
  final String impuDescripcion;
  final int impuId;

  Hotel({
    required this.hoteId,
    required this.hoteNombre,
    required this.hoteDireccionExacta,
    required this.hoteHoraSalida,
    required this.hotePrecioTodoIncluido,
    required this.hoteEstrellas,
    required this.hoteImagen,
    required this.ciudId,
    required this.ciudDescripcion,
    required this.estaDescripcion,
    required this.paisDescripcion,
    required this.haHoPrecioPorNoche,
    required this.hoteUsuaCreacion,
    required this.hoteFechaCreacion,
    this.hoteUsuaModifica,
    this.hoteFechaModifica,
    required this.hoteEstado,
    required this.hoteTelefono,
    required this.hoteCorreo,
    required this.hoteResena,
    required this.paisPorcentajeImpuesto,
    required this.impuDescripcion,
    required this.impuId,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hoteId: json['hote_Id'],
      hoteNombre: json['hote_Nombre'],
      hoteDireccionExacta: json['hote_DireccionExacta'],
      hoteHoraSalida: json['hote_HoraSalida'],
      hotePrecioTodoIncluido: json['hote_PrecioTodoIncluido'].toDouble(),
      hoteEstrellas: json['hote_Estrellas'],
      hoteImagen: json['hote_Imagen'],
      ciudId: json['ciud_Id'],
      ciudDescripcion: json['ciud_Descripcion'],
      estaDescripcion: json['esta_Descripcion'],
      paisDescripcion: json['pais_Descripcion'],
      haHoPrecioPorNoche: json['haHo_PrecioPorNoche'].toDouble(),
      hoteUsuaCreacion: json['hote_Usua_Creacion'],
      hoteFechaCreacion: json['hote_Fecha_Creacion'],
      hoteUsuaModifica: json['hote_Usua_Modifica'],
      hoteFechaModifica: json['hote_Fecha_Modifica'],
      hoteEstado: json['hote_Estado'],
      hoteTelefono: json['hote_Telefono'],
      hoteCorreo: json['hote_Correo'],
      hoteResena: json['hote_Reseña'],
      paisPorcentajeImpuesto: json['pais_PorcentajeImpuesto'].toDouble(),
      impuDescripcion: json['impu_Descripcion'],
      impuId: json['impu_Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hote_Id': hoteId,
      'hote_Nombre': hoteNombre,
      'hote_DireccionExacta': hoteDireccionExacta,
      'hote_HoraSalida': hoteHoraSalida,
      'hote_PrecioTodoIncluido': hotePrecioTodoIncluido,
      'hote_Estrellas': hoteEstrellas,
      'hote_Imagen': hoteImagen,
      'ciud_Id': ciudId,
      'ciud_Descripcion': ciudDescripcion,
      'esta_Descripcion': estaDescripcion,
      'pais_Descripcion': paisDescripcion,
      'haHo_PrecioPorNoche': haHoPrecioPorNoche,
      'hote_Usua_Creacion': hoteUsuaCreacion,
      'hote_Fecha_Creacion': hoteFechaCreacion,
      'hote_Usua_Modifica': hoteUsuaModifica,
      'hote_Fecha_Modifica': hoteFechaModifica,
      'hote_Estado': hoteEstado,
      'hote_Telefono': hoteTelefono,
      'hote_Correo': hoteCorreo,
      'hote_Reseña': hoteResena,
      'pais_PorcentajeImpuesto': paisPorcentajeImpuesto,
      'impu_Descripcion': impuDescripcion,
      'impu_Id': impuId,
    };
  }

  @override
  String toString() {
    return 'Hotel: $hoteNombre, ID: $hoteId';
  }
}
