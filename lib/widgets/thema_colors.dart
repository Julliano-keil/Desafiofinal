// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import '../casos_de_usos/settings_code.dart';

class SettingsWidhts extends StatefulWidget {
  SettingsWidhts({super.key});

  final Settingscode color = Settingscode();

  @override
  State<SettingsWidhts> createState() => _SettingsWidhtsState();
}

class _SettingsWidhtsState extends State<SettingsWidhts> {
  Settingscode settings = Settingscode();

  Widget _createSwitch(
    String titulo,
    bool value,
    final Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(
        titulo,
        style: const TextStyle(fontSize: 25, color: Colors.black),
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
          children: [
            _createSwitch('Mudar para tema padrao', settings.themeColor,
                (value) => setState(() => settings.themeColor = value)),
          ],
        )),
      ],
    );
  }
}
