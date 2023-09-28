import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../Screens/registered_people_screen.dart';
import '../Screens/settings_screen.dart';
import '../screens/signin_screen.dart';

final ZoomDrawerController z = ZoomDrawerController();

class Zoom extends StatelessWidget {
  const Zoom({Key? key, required this.mainScreen}) : super(key: key);

  final Widget mainScreen;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: 50,
      showShadow: true,
      shadowLayer1Color: Colors.white12,
      shadowLayer2Color: Colors.white10,
      openCurve: Curves.fastOutSlowIn,
      mainScreenScale: 0.2,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      angle: -8.0,
      menuBackgroundColor: Colors.black,
      mainScreen: mainScreen,
      moveMenuScreen: false,
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
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.people_alt_outlined),
                iconColor: Colors.amber,
                title: const Text(
                  'Lista de associados',
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Registeredpeople()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.sensor_door_outlined),
                iconColor: Colors.amber,
                title: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
