import 'package:flutter/material.dart';
import '../casos_de_usos/settings_code.dart';
import '../widgets/registered_people.dart';

class Registeredpeople extends StatelessWidget {
  Registeredpeople({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pushReplacementNamed('/Homepage'),
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,
        title: const Text('Associados'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: color.cor,
        child: Stack(
          children: [
            Container(
              color: color.cor,
              width: 430,
              height: 400,
              child: Container(
                width: 420,
                height: 382,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(200))),
                //
              ),
            ),
            Positioned(
              top: 400,
              child: Container(
                color: Colors.amber,
                width: 430,
                height: 411,
                child: Container(
                  width: 420,
                  height: 400,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(150))),
                ),
              ),
            ),
            const RegisteredList(),
          ],
        ),
      ),
    );
  }
}
