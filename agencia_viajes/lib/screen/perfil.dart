import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
            child: UserProfile(
              user: User(
                name: 'Juan',
                lastName: 'Pérez',
                image: 'assets/images/profile_image.jpg', // Coloca la ruta de la imagen del usuario
                age: 30,
                location: 'Ciudad de México',
                occupation: 'Desarrollador',
                email: 'juan@example.com',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String lastName;
  final String image;
  final int age;
  final String location;
  final String occupation;
  final String email;

  User({
    required this.name,
    required this.lastName,
    required this.image,
    required this.age,
    required this.location,
    required this.occupation,
    required this.email,
  });
}

class UserProfile extends StatelessWidget {
  final User user;

  UserProfile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 16),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(user.image),
          ),
        ),
        SizedBox(height: 20),
        Text(
          '${user.name} ${user.lastName}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Edad: ${user.age}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Text(
          'Ubicación: ${user.location}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Text(
          'Ocupación: ${user.occupation}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Text(
          'Correo Electrónico: ${user.email}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
