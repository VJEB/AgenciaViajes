import 'package:agencia_viajes/models/persona.dart';
import 'package:agencia_viajes/screen/persona_registro_screen.dart';
import 'package:agencia_viajes/screen/usuario_registro_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double kHorizontalPadding = 24;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.black45,
            toolbarHeight: 125,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    'https://kobybucketvjeb.s3.us-east-2.amazonaws.com/avatar_usuario.png',
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Juan Pérez',
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
                        pantalla: RegistroPersona(persona: 
                          Persona(
                              cargId: 1, 
                              esCiId: 2,
                              persApellido: "Espinoza",
                              ciudId: 1,
                              persDNI: "0501",
                              persFechaCreacion: "",
                              persUsuaCreacion: 1,
                              persHabilitado: true,
                              persNombre: "Victor",
                              persPasaporte: "FLNFE",
                              persSexo: "M",
                              persTelefono: 314667,
                              persEmail: "correo@gmail.com",
                              persId: 30),
                        ),
                      ),
                      const ProfileListTile(
                        label: 'Editar Usuario',
                        iconData: Icons.edit,
                        pantalla: RegistroUsuario(persId: 1,),
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
    super.key, required this.pantalla,
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
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => pantalla));
          },
        ),
        const Divider(thickness: .75, color: Color(0xFFFFBD59)), // Cambio de color a blanco
      ],
    );
  }
}
