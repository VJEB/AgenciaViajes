class Usuario {
  int? usuaId;
  String? rolId;
  String? persEmail;
  int? emplId;
  int? usuaCreacion;
  final String? usuaFechaCreacion;
  int? usuaModifica;
  final String? usuaFechaModifica;
  String? usuaContrasena;
  String? usuaUsuario;
  bool? admin;
  String? empleado;
  bool? usuaAdministrador;

  Usuario({
    this.usuaId,
    this.rolId,
    this.persEmail,
    this.emplId,
    this.usuaCreacion,
    this.usuaFechaCreacion,
    this.usuaContrasena,
    this.usuaModifica,
    this.usuaFechaModifica,
    this.usuaUsuario,
    this.admin,
    this.usuaAdministrador,
    this.empleado,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      usuaAdministrador: json['Usua_Administrador'] as bool?,
      usuaId: json['usua_Id'] as int?,
      emplId: json['pers_Id'] as int?,
      usuaCreacion: json['usua_Creacion'] as int?,
      usuaFechaCreacion: json['usua_Fecha_Creacion'],
      usuaModifica: json['usua_Modificador'] as int?,
      usuaFechaModifica: json['usua_Fecha_Modifica'],
      usuaContrasena: json['usua_Contraseña'] as String?,
      usuaUsuario: json['usua_Usuario'] as String?,
      admin: json['admin'] as bool?,
      empleado: json['empl_Nombre'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usua_Usua_Creacion': usuaCreacion,
      'usua_Fecha_Creacion': usuaFechaCreacion,
      'usua_Usuario': usuaUsuario,
      'usua_Contra': usuaContrasena,
      'usua_Email': persEmail,
      'pers_Id': emplId,
    };
  }
}
