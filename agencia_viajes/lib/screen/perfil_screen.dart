
import 'package:agencia_viajes/models/persona.dart';
import 'package:agencia_viajes/screen/persona_registro_screen.dart';
import 'package:agencia_viajes/screen/usuario_registro_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/models/usuario.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State {
  late UsuarioModel _usuario = UsuarioModel(
      usuaId: -1,
      usuaUsuario: 'Cargando...',
      usuaUrlImagen: 'Cargando...',
      cargId: -1,
      esCiId: -1,
      persona: 'Cargando',
      persPasaporte: 'Cargando.. ',
      persSexo: 'Cargando..',
      persTelefono: -1,
      persEmail: 'Cargando..',
      persId: -1);

  @override
  void initState() {
    super.initState();
    _loadUsuario(); // Llama a la función para cargar los datos del usuario al iniciar la pantalla
  }

  // Función asincrónica para cargar los datos del usuario desde SharedPreferences
  Future<void> _loadUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final int? usuaId = prefs.getInt('usua_Id');
    final int? persId = prefs.getInt('pers_Id');
    final String? usuaUsuario = prefs.getString('usua_Usuario');
    final String? usuaContra = prefs.getString('usua_Contra');
    final String? usuaUrlImagen = prefs.getString('usua_UrlImagen');
    final int? cargId = prefs.getInt('carg_Id');
    final int? esCiId = prefs.getInt('esCi_Id');
    final String? persona = prefs.getString('persona');
    final String? persPasaporte = prefs.getString('pers_Pasaporte');
    final String? persSexo = prefs.getString('pers_Sexo');
    final int? pers_Telefono = prefs.getInt('pers_Telefono');
    final String? pers_Email = prefs.getString('pers_Email');
    final String? pers_DNI = prefs.getString('pers_DNI');
    // Verifica si los datos del usuario no son nulos y crea una instancia de UsuarioModel
    if (usuaId != null &&
        usuaUsuario != null &&
        usuaContra != null &&
        persId != null 
        ) {
      setState(() {
        _usuario = UsuarioModel(
            usuaId: usuaId,
            usuaUsuario: usuaUsuario,
            usuaContra: usuaContra,
            usuaUrlImagen: usuaUrlImagen,
            persId: persId,
            cargId: cargId,
            esCiId: esCiId,
            persona: persona,
            persPasaporte: persPasaporte,
            persSexo: persSexo,
            persTelefono: pers_Telefono,
            persEmail: pers_Email,
            persDNI: pers_DNI,
            );
      });
    } else {
      // Maneja el caso en que no se encuentren datos del usuario en SharedPreferences
    }
  }

  @override
  Widget build(BuildContext context) {
    const double kHorizontalPadding = 24;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
           SliverAppBar(
            backgroundColor: Colors.black45,
            toolbarHeight: 125,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    _usuario.usuaUrlImagen ?? '',
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     _usuario.persona ?? '',
                      // 'Juan Pérez',
                      style: TextStyle(
                        color: Colors.white, // Cambio de color a negro
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Configuraciones'),
                      ProfileListTile(
                        label: 'Informacion Personal',
                        iconData: Icons.person_outline,
                        pantalla: RegistroPersona(
                          persona: Persona(
                              cargId: _usuario.cargId,
                              esCiId: _usuario.esCiId ?? 0,
                              persApellido: _usuario.persona!.split(" ")[1],
                              ciudId: _usuario.ciudId ?? 0,
                              persDNI: _usuario.persDNI ?? '',
                              persFechaCreacion: "",
                              persUsuaCreacion: 1,
                              persHabilitado: true,
                              persNombre: _usuario.persona!.split(" ")[0],
                              persPasaporte: _usuario.persPasaporte ?? '',
                              persSexo: _usuario.persSexo ?? '',
                              persTelefono: _usuario.persTelefono ?? 0,
                              persEmail: _usuario.persEmail,
                              persId: _usuario.persId),
                        ),
                      ),
                      const ProfileListTile(
                        label: 'Editar Usuario',
                        iconData: Icons.edit,
                        pantalla: RegistroUsuario(
                          persId: 1,
                        ),
                      ),
                      const ProfileListTile(
                        label: 'Mis Tarjetas',
                        iconData: Icons.card_giftcard_outlined,
                        pantalla: RegistroUsuario(persId: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String label) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFFFBD59), // Cambio de color a naranja
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    this.label = '',
    this.labelColor = Colors.white, // Cambio de color a blanco
    this.subtitle,
    this.iconData,
    super.key,
    required this.pantalla,
  });

  final String label;
  final Color labelColor;
  final String? subtitle;
  final IconData? iconData;
  final Widget pantalla;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: labelColor, // Cambio de color a blanco
            ),
          ),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          trailing: iconData != null
              ? Icon(
                  iconData,
                  color: Colors.white, // Cambio de color a blanco
                  size: 36,
                )
              : null,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => pantalla));
          },
        ),
        const Divider(
            thickness: .75,
            color: Color(0xFFFFBD59)), // Cambio de color a blanco
      ],
    );
  }
}
