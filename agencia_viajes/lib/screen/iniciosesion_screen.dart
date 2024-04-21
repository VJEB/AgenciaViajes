/*
  Flutter UI
  ----------
  lib/screens/simple_login.dart
*/

import 'package:agencia_viajes/screen/persona_registro_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_viajes/screen/layout.dart';

class InicioSesion extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const InicioSesion({this.onSubmitted, super.key});
  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  late String email, password;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';

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
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = 'El correo es inválido';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Por favor ingrese su contraseña';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Layout()),
    );
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                'Bienvenido,',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFBD59),
                ),
              ),
              SizedBox(height: screenHeight * .01),
              const Text(
                'Inicia sesión para continuar!',
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
                    email = value;
                  });
                },
                labelText: 'Correo electrónico',
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              TextInput(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                onSubmitted: (val) => submit(),
                labelText: 'Constraseña',
                errorText: passwordError,
                obscureText: true,
                textInputAction: TextInputAction.next,
                // style: tex,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Olvidé mi contraseña',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              FormButton(
                text: 'Iniciar Sesión',
                onPressed: submit,
                iconData: Icons.login,
              ),
              SizedBox(
                height: screenHeight * .075,
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegistroPersona(),
                  ),
                ),
                child: RichText(
                  text: const TextSpan(
                    text: "Soy un usuario nuevo, ",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Registrarse',
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
