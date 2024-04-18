/*
  Flutter UI
  ----------
  lib/screens/simple_login.dart
*/

import 'package:flutter/material.dart';

class SimpleLoginScreen extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, super.key});
  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
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
                child: Image.asset(
                  'lib/assets/Logo-agencia-viajes.png', // Replace 'your_image.png' with your actual image asset path
                  height: screenHeight * 0.6, // Adjust the height as needed
                ),
              ),
              SizedBox(height: screenHeight * .12),
              const Text(
                'Bienvenido,',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFBD59),
                ),
              ),
              SizedBox(height: screenHeight * .01),
              const Text(
                'Inicia sesión para continuar!',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(198, 255, 189, 89),
                ),
              ),
              SizedBox(height: screenHeight * .12),
              TextFormField(
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
              TextFormField(
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
                height: screenHeight * .075,
              ),
              FormButton(
                text: 'Iniciar Sesión',
                onPressed: submit,
              ),
              SizedBox(
                height: screenHeight * .15,
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SimpleRegisterScreen(),
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

class SimpleRegisterScreen extends StatefulWidget {
  final Function(String? email, String? password)? onSubmitted;

  const SimpleRegisterScreen({this.onSubmitted, super.key});

  @override
  State<SimpleRegisterScreen> createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
  late String email, password, confirmPassword;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    confirmPassword = '';

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

  void submit() {
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
                child: Image.asset(
                  'lib/assets/Logo-agencia-viajes.png', // Replace 'your_image.png' with your actual image asset path
                  height: screenHeight * 0.6, // Adjust the height as needed
                ),
              ),
              SizedBox(height: screenHeight * .12),
              const Text(
                'Crear una cuenta,',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFBD59),
                ),
              ),
              SizedBox(height: screenHeight * .01),
              const Text(
                'Registrate para empezar!',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(198, 255, 189, 89),
                ),
              ),
              SizedBox(height: screenHeight * .12),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                labelText: 'Email',
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              TextFormField(
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
              TextFormField(
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
                height: screenHeight * .075,
              ),
              FormButton(
                text: 'Registrarse',
                onPressed: submit,
              ),
              SizedBox(
                height: screenHeight * .125,
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
  final Function? onPressed;
  const FormButton({this.text = '', this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class TextFormField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  const TextFormField(
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
