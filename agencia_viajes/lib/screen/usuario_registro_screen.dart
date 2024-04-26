/*
  Flutter UI
  ----------
  lib/screens/simple_login.dart
*/

import 'dart:convert';

import 'package:agencia_viajes/models/usuario.dart';
import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:agencia_viajes/screen/persona_registro_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistroUsuario extends StatefulWidget {
  final int persId;

  const RegistroUsuario({required this.persId, super.key});

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  late String usuario, persEmail, password, confirmPassword;
  String? usuarioError, emailError, passwordError;

  late int? persId;

  @override
  void initState() {
    super.initState();
    usuario = '';
    persId = widget.persId;
    persEmail = '';
    password = '';
    confirmPassword = '';
    usuarioError = null;
    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;

    if (usuario.isEmpty) {
      setState(() {
        usuarioError = 'El usuario es inválido';
      });
      isValid = false;
    }

    if (persEmail.isEmpty || !emailExp.hasMatch(persEmail)) {
      setState(() {
        emailError = 'El correo es inválido';
      });
      isValid = false;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = 'Por favor ingrese su contraseña';
      });
      isValid = false;
    }
    if (password != confirmPassword) {
      setState(() {
        passwordError = 'Las contraseñas no coinciden';
      });
      isValid = false;
    }

    return isValid;
  }

  Future<void> postUsuario() async {
    const String url = "https://etravel.somee.com/API/Usuario/Create";
    UsuarioModel usua = UsuarioModel(
        persId: persId,
        usuaUsuario: usuario,
        usuaContra: password,
        persEmail: persEmail,
        usuaUsuaCreacion: 1,
        usuaFechaCreacion: DateTime.now().toUtc().toIso8601String());

    var resultado = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usua.toJson()),
    );

    if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Color.fromARGB(255, 80, 239, 136),
            content:
                Text('Usuario registrado con exito! Por favor inicie sesión.')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const InicioSesion()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[400],
            content: const Text('Ya existe este usuario')),
      );
    }
  }

  Future<void> submit() async {
    if (validate()) {
      await postUsuario();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro de usuarios",
          style: TextStyle(color: Color(0xFFFFBD59)),
        ),
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   tooltip: 'Volver',
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (_) => const RegistroPersona()));
        //   },
        // ),
        // iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(maxHeight: 300),
                child: Image.asset(
                  'lib/assets/Logo-agencia-viajes.png', // Replace 'your_image.png' with your actual image asset path
                  height: screenHeight * 0.6, // Adjust the height as needed
                ),
              ),
              const Text(
                'Crear una cuenta,',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFBD59),
                ),
              ),
              SizedBox(height: screenHeight * .01),
              const Text(
                'Registrate para empezar!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(198, 255, 189, 89),
                ),
              ),
              SizedBox(height: screenHeight * .05),
              TextInput(
                onChanged: (value) {
                  setState(() {
                    usuario = value;
                  });
                },
                labelText: 'Usuario',
                errorText: usuarioError,
                textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .05),
              TextInput(
                onChanged: (value) {
                  setState(() {
                    persEmail = value;
                  });
                },
                labelText: 'Correo electrónico',
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              TextInput(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                labelText: 'Contraseña',
                errorText: passwordError,
                obscureText: true,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              TextInput(
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                },
                onSubmitted: (value) => submit(),
                labelText: 'Confirmar Contraseña',
                errorText: passwordError,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              FormButton(
                text: 'Registrarse',
                onPressed: submit,
              ),
              SizedBox(
                height: screenHeight * .075,
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: RichText(
                  text: const TextSpan(
                    text: "Ya tengo una cuenta, ",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Iniciar Sesión',
                        style: TextStyle(
                          color: Color(0xFFFFBD59),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final IconData? iconData; // Icon data for the button icon
  final Function? onPressed;
  const FormButton({this.text = '', this.iconData, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: 150, // Set the maximum width here
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) // Conditionally display the icon
              Icon(iconData),
            const SizedBox(width: 8), // Add some spacing between icon and text
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  const TextInput(
      {this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFFFFBD59)),
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
