import 'package:flutter/material.dart';

class BaseForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controler;

  const BaseForm({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.controler,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controler,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
          hintText: hintText,
          labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
          floatingLabelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
