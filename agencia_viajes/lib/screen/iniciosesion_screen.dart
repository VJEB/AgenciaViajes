import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agencia_viajes/screen/layout.dart';
import 'package:agencia_viajes/screen/persona_registro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agencia_viajes/models/usuario.dart';
class InicioSesion extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const InicioSesion({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  late String email, password;
  UsuarioModel? usuario; 
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

  Future<void> submit() async {
  
    // Check if fields are empty before making the request
  if (email.isEmpty || password.isEmpty) {
    setState(() {
      emailError = email.isEmpty ? 'Por favor ingrese su correo electrónico' : null;
      passwordError = password.isEmpty ? 'Por favor ingrese su contraseña' : null;
    });
    return;
  }
  else{
 String url = 'https://etravel.somee.com/API/Usuario/Login/$email/$password';

    try {
      // Make the HTTP request
      final response = await http.get(Uri.parse(url));

     
      if (response.statusCode == 200) {
        
        final responseData = jsonDecode(response.body);

          final usuario = UsuarioModel.fromJson(responseData['data'][0]);

        // Almacena los datos del usuario en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('usua_Id', usuario.usuaId ?? 0);
        prefs.setInt('pers_Id', usuario.persId ?? 0);
        prefs.setString('usua_Usuario', usuario.usuaUsuario ?? '');
        prefs.setString('usua_Contra', usuario.usuaContra ?? '');
        prefs.setString('usua_UrlImagen', usuario.usuaUrlImagen ?? '');
        prefs.setInt('carg_Id', usuario.cargId ?? 0);
        prefs.setInt('esCi_Id', usuario.esCiId ?? 0);
         prefs.setString('persona', usuario.persona ?? '');
      prefs.setString('pers_Pasaporte', usuario.persPasaporte ?? '');
       prefs.setString('pers_Sexo', usuario.persSexo ?? '');
       prefs.setString('pers_DNI', usuario.persDNI ?? '');
        prefs.setInt('pers_Telefono', usuario.persTelefono ?? 0);
        prefs.setString('pers_Email', usuario.persEmail ?? '');
        
          // Navigate to another page if login is successful
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Layout()),
          );
        }
         else {
         
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuario o contraseña incorrectos'),
              backgroundColor: Colors.red,
            ),
          );
          }
      } 
     catch (e) {
      
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
                labelText: 'Contraseña',
                errorText: passwordError,
                obscureText: true,
                textInputAction: TextInputAction.next,
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
  const FormButton({this.text = '', this.iconData, this.onPressed, Key? key}) : super(key: key);

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
