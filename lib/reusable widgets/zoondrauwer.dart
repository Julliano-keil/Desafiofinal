import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Screens/registered_people_screen.dart';
import '../Screens/settings_screen.dart';
import '../casos_de_usos/settings_code.dart';
import '../data_repositories/person_controler.dart';
import '../data_repositories/signup_controller.dart';

///controller
final ZoomDrawerController z = ZoomDrawerController();

///responsible for showing a drawer with routes for configuration,
/// user list and exit
class Zoom extends StatelessWidget {
  ///constructor with required parameters
  const Zoom({super.key, required this.mainScreen});

  ///home page
  final Widget mainScreen;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context, listen: false);
    final settings = Provider.of<Settingscode>(context);
    final userid = state.loggedUser?.id;
    final photouser = state.loggedUser?.imageuser;
    final nameUser = state.loggedUser?.storeName;

    final size = MediaQuery.of(context).size;

    return ZoomDrawer(
      controller: z,
      borderRadius: 50,
      showShadow: true,
      boxShadow: const [BoxShadow(color: Colors.black)],
      shadowLayer1Color: Colors.transparent,
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
              SizedBox(
                height: size.height * 0.28,
              ),
              Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 59,
                      backgroundImage: photouser != null
                          ? FileImage(File(photouser))
                          : Image.asset('imagens/logoEd.png').image,
                    ),
                  ),
                  Positioned(
                    top: size.width / 3000,
                    left: size.width / 7,
                    child: Container(
                      width: 126,
                      height: 118,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 100,
              ),
              Center(
                child: Text(
                  nameUser!,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: size.height / 30,
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
              SizedBox(
                height: size.height * 0.25,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '  Versao : 13.0.0',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
