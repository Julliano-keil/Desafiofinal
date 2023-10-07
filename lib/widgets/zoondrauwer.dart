import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../Screens/registered_people_screen.dart';
import '../Screens/settings_screen.dart';
import '../repositorio_de_dados/person_controler.dart';

final ZoomDrawerController z = ZoomDrawerController();

class Zoom extends StatelessWidget {
  const Zoom({Key? key, required this.mainScreen}) : super(key: key);

  final Widget mainScreen;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context);
    final userid = state.loggedUser!.id;

    return ZoomDrawer(
      controller: z,
      borderRadius: 50,
      showShadow: true,
      boxShadow: const [BoxShadow(color: Colors.black)],
      shadowLayer1Color: Colors.white12,
      shadowLayer2Color: Colors.white10,
      closeCurve: Curves.fastOutSlowIn,
      openCurve: Curves.fastOutSlowIn,
      overlayBlend: BlendMode.hue,
      androidCloseOnBackTap: true,
      menuScreenWidth: 245,
      mainScreenScale: 0.2,
      slideWidth: MediaQuery.of(context).size.width * 0.60,
      duration: const Duration(milliseconds: 500),
      angle: -8.0,
      menuBackgroundColor: Colors.black,
      mainScreen: mainScreen,
      moveMenuScreen: true,
      menuScreen: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: const Color.fromARGB(255, 2, 2, 2),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.all(20),
                color: const Color.fromARGB(255, 0, 0, 0),
                child: Image.asset(
                  'imagens/logojk.png',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                iconColor: Colors.amber,
                title: const Text(
                  'Configurações',
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () async {
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              userid == 1
                  ? ListTile(
                      leading: const Icon(Icons.people_alt_outlined),
                      iconColor: Colors.amber,
                      title: const Text(
                        'Lista de associados',
                        style: TextStyle(color: Colors.amber),
                      ),
                      onTap: () async {
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Registeredpeople()),
                        );
                      },
                    )
                  : Container(),
              ListTile(
                leading: const Icon(Icons.sensor_door_outlined),
                iconColor: Colors.amber,
                title: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () async {
                  await SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
