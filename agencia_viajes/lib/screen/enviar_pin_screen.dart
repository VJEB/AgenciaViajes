import 'package:agencia_viajes/screen/validar_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EnviarPin extends StatefulWidget {
  const EnviarPin({super.key});
  @override
  State<EnviarPin> createState() => _EnviarPinState();
}

class _EnviarPinState extends State<EnviarPin> {
  String usuario = '';
  String? usuarioError;

  @override
  void initState() {
    super.initState();
  }

  void resetErrorText() {
    setState(() {
      usuarioError = null;
    });
  }

  bool validate() {
    resetErrorText();
    bool isValid = true;

    if (usuario.isEmpty) {
      setState(() {
        usuarioError = 'Por favor ingrese su usuario';
      });
      isValid = false;
    }

    return isValid;
  }

  Future<void> submit() async {
    // Check if fields are empty before making the request
    if (usuario.isEmpty) {
      setState(() {
        usuarioError = usuario.isEmpty ? 'Por favor ingrese su usuario' : null;
      });
      return;
    } else {
      String url =
          'https://localhost:44372/API/Usuario/EnviarCodigo?Usuario=${usuario}';

      try {
        // Make the HTTP request
        final response = await http.post(Uri.parse(url));

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ValidarPin()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No existe ese usuaio"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
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
                'Por favor bríndanos tu usuario para continuar',
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
                // textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              FormButton(
                text: 'Enviar código de verificación',
                onPressed: submit,
                iconData: Icons.mail,
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
      Key? key})
      : super(key: key);

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
