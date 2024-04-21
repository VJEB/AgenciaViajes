class Persona {
  final int? persId;
  final String persDNI;
  final String persNombre;
  final String persApellido;
  final String persSexo;
  final int persTelefono;
  final int esCiId;
  final String ciudId;
  final int persUsuaCreacion;
  final String persFechaCreacion;
  final int? persUsuaModifica;
  final String? persFechaModifica;
  final String? persHabilitado;
  final String persPasaporte;
  final String? persEmail;
  final int? cargId;

  Persona({
    this.persId,
    required this.persDNI,
    required this.persNombre,
    required this.persApellido,
    required this.persSexo,
    required this.persTelefono,
    required this.esCiId,
    required this.ciudId,
    required this.persUsuaCreacion,
    required this.persFechaCreacion,
    this.persUsuaModifica,
    this.persFechaModifica,
    this.persHabilitado,
    required this.persPasaporte,
    this.persEmail,
    this.cargId,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      persId: json['pers_Id'],
      persDNI: json['pers_DNI'],
      persNombre: json['pers_Nombre'],
      persApellido: json['pers_Apellido'],
      persSexo: json['pers_Sexo'],
      persTelefono: json['pers_Telefono'],
      esCiId: json['esCi_Id'],
      ciudId: json['ciud_Id'],
      persUsuaCreacion: json['pers_Usua_Creacion'],
      persFechaCreacion: json['pers_Fecha_Creacion'],
      persUsuaModifica: json['pers_Usua_Modifica'],
      persFechaModifica: json['pers_Fecha_Modifica'],
      persHabilitado: json['pers_Habilitado'],
      persPasaporte: json['pers_Pasaporte'],
      persEmail: json['pers_Email'],
      cargId: json['carg_Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pers_Id': persId,
      'pers_DNI': persDNI,
      'pers_Nombre': persNombre,
      'pers_Apellido': persApellido,
      'pers_Sexo': persSexo,
      'pers_Telefono': persTelefono,
      'esCi_Id': esCiId,
      'ciud_Id': ciudId,
      'pers_Usua_Creacion': persUsuaCreacion,
      'pers_Fecha_Creacion': persFechaCreacion,
      'pers_Usua_Modifica': persUsuaModifica,
      'pers_Fecha_Modifica': persFechaModifica,
      'pers_Habilitado': persHabilitado,
      'pers_Pasaporte': persPasaporte,
      'pers_Email': persEmail,
      'carg_Id': cargId,
    };
  }

  @override
  String toString() {
    return '$persNombre $persApellido';
  }
}
