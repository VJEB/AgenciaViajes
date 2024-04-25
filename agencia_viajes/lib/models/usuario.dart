class UsuarioModel {
  int? usuaId;
  String? usuaUsuario;
  String? usuaContra;
  bool? usuaAdmin;
  int? rolId;
  String? rolDescripcion;
  int? usuaUsuaCreacion;
  String? persona;
  String? usuaUrlImagen;
  String? persDNI;
  String? persSexo;
  int? persTelefono;
  String? persPasaporte;
  int? ciudId;
  String? ciudDescripcion;
  int? esCiId;
  String? esCiDescripcion;
  int? cargId;
  String? cargDescripcion;
  int? estaId;
  String? estaDescripcion;
  int? paisId;
  String? paisDescripcion;

  UsuarioModel({
    this.usuaId,
    this.usuaUsuario,
    this.usuaContra,
    this.usuaAdmin,
    this.rolId,
    this.rolDescripcion,
    this.usuaUsuaCreacion,
    this.persona,
    this.usuaUrlImagen,
    this.persDNI,
    this.persSexo,
    this.persTelefono,
    this.persPasaporte,
    this.ciudId,
    this.ciudDescripcion,
    this.esCiId,
    this.esCiDescripcion,
    this.cargId,
    this.cargDescripcion,
    this.estaId,
    this.estaDescripcion,
    this.paisId,
    this.paisDescripcion,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      usuaId: json['usua_Id'],
      usuaUsuario: json['usua_Usuario'],
      usuaContra: json['usua_Contra'],
      usuaAdmin: json['usua_Admin'],
      rolId: json['rol_Id'],
      rolDescripcion: json['rol_Descripcion'],
      usuaUsuaCreacion: json['usua_Usua_Creacion'],
      persona: json['persona'],
      usuaUrlImagen: json['usua_UrlImagen'],
      persDNI: json['pers_DNI'],
      persSexo: json['pers_Sexo'],
      persTelefono: json['pers_Telefono'],
      persPasaporte: json['pers_Pasaporte'],
      ciudId: json['ciud_Id'],
      ciudDescripcion: json['ciud_Descripcion'],
      esCiId: json['esCi_Id'],
      esCiDescripcion: json['esCi_Descripcion'],
      cargId: json['carg_Id'],
      cargDescripcion: json['carg_Descripcion'],
      estaId: json['esta_Id'],
      estaDescripcion: json['esta_Descripcion'],
      paisId: json['pais_Id'],
      paisDescripcion: json['pais_Descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usua_Id': usuaId,
      'usua_Usuario': usuaUsuario,
      'usua_Contra': usuaContra,
      'usua_Admin': usuaAdmin,
      'rol_Id': rolId,
      'rol_Descripcion': rolId,
      'usua_Usua_Creacion': usuaUsuaCreacion,
      'persona': persona,
      'usua_UrlImagen': usuaUrlImagen,
      'pers_DNI': persDNI,
      'pers_Sexo': persSexo,
      'pers_Telefono': persTelefono,
      'pers_Pasaporte': persPasaporte,
      'ciud_Id': ciudId,
      'ciud_Descripcion': ciudDescripcion,
      'esCi_Id': esCiId,
      'esCi_Descripcion': esCiDescripcion,
      'carg_Id': cargId,
      'carg_Descripcion': cargDescripcion,
      'esta_Id': estaId,
      'esta_Descripcion': estaDescripcion,
      'pais_Id': paisId,
      'pais_Descripcion': paisDescripcion,
    };
  }
}
