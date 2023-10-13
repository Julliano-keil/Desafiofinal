import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Screens/registered_people_screen.dart';
import '../Screens/settings_screen.dart';
import '../casos_de_usos/settings_code.dart';
import '../data_repositories/person_controler.dart';

///controller
final ZoomDrawerController z = ZoomDrawerController();

///responsible for showing a drawer with routes for configuration,
/// user list and exit
class Zoom extends StatelessWidget {
  ///constructor with required parameters
  const Zoom({Key? key, required this.mainScreen}) : super(key: key);

  ///home page
  final Widget mainScreen;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context, listen: false);
    final settings = Provider.of<Settingscode>(context);
    final userid = state.loggedUser?.id;

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
      angle: -7.0,
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
                  'imagens/logonotname.png',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.settings),
                  iconColor: settings.ligthMode ? Colors.amber : Colors.white,
                  title: Text(
                    'Configurações',
                    style: TextStyle(
                        color:
                            settings.ligthMode ? Colors.amber : Colors.white),
                  ),
                  onTap: () async => Get.to(const Settings())),
              userid == 1
                  ? ListTile(
                      leading: const Icon(Icons.people_alt_outlined),
                      iconColor:
                          settings.ligthMode ? Colors.amber : Colors.white,
                      title: Text(
                        'Lista de associados',
                        style: TextStyle(
                            color: settings.ligthMode
                                ? Colors.amber
                                : Colors.white),
                      ),
                      onTap: () async => await Get.to(const Registeredpeople()))
                  : Container(),
              ListTile(
                leading: const Icon(Icons.sensor_door_outlined),
                iconColor: settings.ligthMode ? Colors.amber : Colors.white,
                title: Text(
                  'Sair',
                  style: TextStyle(
                      color: settings.ligthMode ? Colors.amber : Colors.white),
                ),
                onTap: () async {
                  await Get.offAndToNamed('/SignIn');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
