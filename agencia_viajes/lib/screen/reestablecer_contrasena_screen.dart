/*
  Flutter UI
  ----------
  lib/screens/simple_login.dart
*/

import 'dart:convert';

import 'package:agencia_viajes/models/usuario.dart';
import 'package:agencia_viajes/screen/iniciosesion_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReestablecerContrasena extends StatefulWidget {
  final String pin;
  const ReestablecerContrasena({super.key, required this.pin});

  @override
  State<ReestablecerContrasena> createState() => _ReestablecerContrasenaState();
}

class _ReestablecerContrasenaState extends State<ReestablecerContrasena> {
  late String password, confirmPassword;
  String? passwordError;

  late int? persId;
  late String? pin;

  @override
  void initState() {
    super.initState();
    pin = widget.pin;
    password = '';
    confirmPassword = '';
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    bool isValid = true;

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

  Future<void> postContra() async {
    String url =
        "https://etravel.somee.com/API/Usuario/restablecer/${pin as String}";
    UsuarioModel usua = UsuarioModel(
        persId: 0,
        usuaUsuario: "usuario",
        usuaContra: password,
        persEmail: "persEmail",
        usuaUsuaCreacion: 1,
        usuaFechaCreacion: DateTime.now().toUtc().toIso8601String(),
        usuaId: 0,
        usuaAdmin: false,
        rolId: 0,
        usuaFechaModifica: DateTime.now().toUtc().toIso8601String(),
        usuaUsuaModifica: 0,
        usuaUrlImagen: "aa",
        usuaEstado: false);

    var resultado = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usua.toJson()),
    );

    if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Color.fromARGB(255, 80, 239, 136),
            content: Text(
                'Contraseña actualizada con éxito! Por favor inicie sesión.')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const InicioSesion()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[400],
            content: const Text(
                'Ha ocurrido un error al intentar cambiar la contraseña')),
      );
    }
  }

  Future<void> submit() async {
    if (validate()) {
      await postContra();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reestablecer contraseña",
          style: TextStyle(color: Color(0xFFFFBD59)),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(color: Color(0xFFFFBD59)),
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
                'Reestablecer contraseña,',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFBD59),
                ),
              ),
              SizedBox(height: screenHeight * .01),
              const Text(
                'Ya no olvide su contraseña porfa',
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
                text: 'Cambiar contraseña',
                onPressed: submit,
              ),
              SizedBox(
                height: screenHeight * .075,
              ),
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
