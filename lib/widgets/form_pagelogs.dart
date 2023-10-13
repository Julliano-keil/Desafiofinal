import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

///class responsible for providing an editable textFormField
class BaseForm extends StatelessWidget {
  /// text that informs the user to take action
  final String labelText;

  /// text exemple
  final String hintText;

  ///obscureText
  final bool truee;

  ///format text and numbers
  final String? formatter;

  ///suggested keyboard
  final TextInputType keyboardType;

  ///valid form
  final String? Function(String?)? validator;

  ///controller
  final TextEditingController? controler;

  ///constructor with required parameters
  const BaseForm(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.keyboardType,
      this.validator,
      this.controler,
      required this.truee,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: truee,
        controller: controler,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        inputFormatters: [MaskTextInputFormatter(mask: formatter)],
        magnifierConfiguration: TextMagnifierConfiguration.disabled,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
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
