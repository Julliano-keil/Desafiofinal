import 'package:flutter/material.dart';

import 'package:jscar/screens/singin_screen.dart';
import 'package:jscar/widgets/button_navigation.dart';

class Pagelogs extends StatelessWidget {
  const Pagelogs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("imagens/logojk.png"),
                Buttonnavigator(
                    onpresed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const SignIn())),
                    text: 'Entrar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}