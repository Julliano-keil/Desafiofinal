import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/settings_code.dart';
import '../repositorio_de_dados/person_controler.dart';
import '../repositorio_de_dados/profile_controller.dart';

class ProfileUser extends StatelessWidget {
  ProfileUser({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<PersonControler>(context);
    final userid = person.loggedUser!.id;
    final userName = person.loggedUser!.nomeloja;
    final userCnpj = person.loggedUser!.cnpj;

    return ChangeNotifierProvider<ProfileController>(
      create: (context) => ProfileController(personid: userid!),
      child: Consumer<ProfileController>(
        builder: (_, state, __) {
          return Scaffold(
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
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(200),
                        ),
                      ),
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(150),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                    width: 400,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.black),
                                    child: state.imageback != null
                                        ? Image.file(
                                            File(state.imageback!),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset('imagens/logoEd.png')),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 245,
                    left: 40,
                    child: Text(
                      userName!,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 117,
                    left: 22,
                    child: Container(
                      width: 126,
                      height: 126,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 25,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 60,
                      backgroundImage: state.controllerImage != null
                          ? FileImage(File(state.controllerImage!))
                          : Image.asset('imagens/logoEd.png').image,
                    ),
                  ),
                  Positioned(
                    top: 100,
                    child: IconButton(
                      onPressed: () async {
                        await state.pickImage();
                      },
                      icon: const Icon(Icons.photo_library_outlined),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: 25,
                    child: Container(
                      width: 350,
                      height: 300,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(0)),
                      child: Column(
                        children: [
                          Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person_pin,
                                    size: 30,
                                  ),
                                  Text(
                                    '  Cnpj : $userCnpj',
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.lock_person_outlined,
                                    size: 30,
                                  ),
                                  Text(
                                    userid == 1
                                        ? '  Nivel : Adiministrador'
                                        : '  Nivel : ${state.nameautonomy}',
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on_outlined,
                                    size: 30,
                                  ),
                                  Text(
                                    userid == 1
                                        ? '  Comiçao: 100%'
                                        : '  Comiçao:'
                                            ' ${state.dealershipPercentag} %',
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
