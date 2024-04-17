import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(5, 10, 255, 0.016),
      child: const Center(
        child: Text(
          "KIONDA PERRIN", 
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
            fontSize: 25,
          ),),
      ),
    );
  }
}