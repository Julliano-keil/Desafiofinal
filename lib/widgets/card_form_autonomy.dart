import 'package:flutter/material.dart';

class CardFormAutonomy extends StatelessWidget {
  final String labelText;
  final TextEditingController? controler;

  const CardFormAutonomy(this.labelText, this.controler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: false,
        controller: controler,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
          floatingLabelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
