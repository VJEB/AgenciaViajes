import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
                    'https://example.com/profile_image.jpg',
                  ),
                ),
                const SizedBox(width: 12),
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
                    const SizedBox(height: 4),
                   
                    const SizedBox(height: 20),
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
                      const ProfileListTile(
                        label: 'Informacion Personal',
                        iconData: Icons.person_outline,
                      ),
                      const ProfileListTile(
                        label: 'Editar Usuario',
                        iconData: Icons.edit,
                      ),

                      const ProfileListTile(
                        label: 'Mis Tarjetas',
                        iconData: Icons.card_giftcard_outlined,
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
          style: TextStyle(
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
    Key? key,
  }) : super(key: key);

  final String label;
  final Color labelColor;
  final String? subtitle;
  final IconData? iconData;

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
        ),
        const Divider(thickness: .75, color: Color(0xFFFFBD59)), // Cambio de color a blanco
      ],
    );
  }
}
