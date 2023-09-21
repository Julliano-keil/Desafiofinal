import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  const DropButton({super.key});

  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  // final List<String> dropdownItems = <>[];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedValue,
            items: dropdownItems.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Escolha um item',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Outro campo de texto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
