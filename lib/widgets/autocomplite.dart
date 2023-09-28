import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';

class AppTextFieldAutoComplete extends StatelessWidget {
  const AppTextFieldAutoComplete({
    required this.suggestions,
    required this.controller,
    this.validator,
    this.focusNode,
    super.key,
    required this.labeltext,
  });

  final List<String> suggestions;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? labeltext;

  @override
  Widget build(BuildContext context) {
    return EasyAutocomplete(
      inputTextStyle: const TextStyle(color: Colors.white),
      suggestions: suggestions,
      validator: validator,
      focusNode: focusNode,
      onChanged: (value) => controller,
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 17),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
