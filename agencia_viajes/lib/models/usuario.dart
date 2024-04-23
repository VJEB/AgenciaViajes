class UsuarioModel {
  int? usua_Id;
  String? role_Id;
  String? empl_Id;
  int? Usua_Creacion;
  int? Usua_Modificador;
  String? Usua_Contrasena;
  String? Usua_Usuario;
  String? Admin;
  String? Empleado;
  bool? Usua_Administrador;

  UsuarioModel({
    this.usua_Id,
    this.role_Id,
    this.empl_Id,
    this.Usua_Creacion,
    this.Usua_Contrasena,
    this.Usua_Modificador,
    this.Usua_Usuario,
    this.Admin,
    this.Usua_Administrador,
    this.Empleado,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      Usua_Administrador : json['Usua_Administrador'] as bool?,
      usua_Id: json['usua_Id'] as int?,
      Usua_Creacion: json['usua_Creacion'] as int?,
      Usua_Modificador: json['usua_Modificador'] as int?,
      Usua_Contrasena: json['usua_Contraseña'] as String?,
      Usua_Usuario: json['usua_Usuario'] as String?,
      Admin: json['admin'] as String?,
      Empleado: json['empl_Nombre'] as String?,
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      
      'Usua_Creacion': Usua_Creacion,
      'Usua_Modificador': Usua_Modificador,
      'Usua_Usuario': Usua_Usuario,
      'Usua_Contraseña': Usua_Contrasena,
      'Usua_Administrador': Usua_Administrador,
      'Role_Id': role_Id,
      'Empl_Id': empl_Id,

    };
  }
}
