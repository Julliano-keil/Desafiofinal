import 'package:flutter/material.dart';
import '../Screens/maindrawer.dart';
import '../casos_de_usos/settings_code.dart';
import '../widgets/registered_people.dart';

class Registeredpeople extends StatelessWidget {
  Registeredpeople({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          const MainDrawer(), //                                     <= drawer
      appBar: AppBar(
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
            const RegisteredList(),
            const SizedBox(),
            // Positioned(
            //     top: 700,
            //     left: 340,
            //     child: PopupMenuButton<String>(
            //         icon: const Icon(
            //           Icons.list,
            //           size: 40,
            //           color: Colors.white,
            //         ),
            //         onSelected: (choice) {
            //           if (choice == 'opcao1') {
            //             Navigator.of(context, rootNavigator: true)
            //                 .pushReplacementNamed('/RegisteredAutonomy',
            //                     arguments: person);
            //           }
            //         },
            //         itemBuilder: (context) {
            //           return <PopupMenuEntry<String>>[
            //             const PopupMenuItem<String>(
            //               value: 'opcao1',
            //               child: Text('Lista de niveis'),
            //             ),
            //           ];
            //         }))
          ],
        ),
      ),
    );
  }
}
