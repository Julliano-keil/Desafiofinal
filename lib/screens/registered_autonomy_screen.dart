import 'package:flutter/material.dart';
import '../Screens/maindrawer.dart';
import '../casos_de_usos/settings_code.dart';
import '../widgets/registered_autonomy.dart';

class RegisteredAutonomy extends StatelessWidget {
  RegisteredAutonomy({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_outlined)),
          backgroundColor: Colors.black,
          title: const Center(
            child: Text('Associados'),
          ),
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
              const RegisteredListAutonomy()
            ],
          ),
        ),
      ),
    );
  }
}
