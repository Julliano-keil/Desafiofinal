import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/settings_code.dart';
import '../data_repositories/person_controler.dart';
import '../data_repositories/profile_controller.dart';

///class responsible for showing relevant user
///information, such as autonomy, photo and name
class ProfileUser extends StatelessWidget {
  ///constructor class
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<PersonControler>(context);
    final settings = Provider.of<Settingscode>(context);
    final userid = person.loggedUser!.id;
    final userName = person.loggedUser!.storeName;
    final userCnpj = person.loggedUser!.cnpj;
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<ProfileController>(
      create: (context) => ProfileController(personid: userid!),
      child: Consumer<ProfileController>(
        builder: (_, state, __) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: settings.ligthMode ? Colors.amber : Colors.white,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    width: 430,
                    height: 400,
                    child: Container(
                      width: 420,
                      height: 382,
                      decoration: BoxDecoration(
                        color: settings.ligthMode ? Colors.amber : Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(200),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 400,
                    child: Container(
                      color: settings.ligthMode ? Colors.amber : Colors.white,
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
                                  child: Image.asset('imagens/logoEd.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.30,
                    left: size.width / 8,
                    child: Text(
                      userName!,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.14,
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
                    top: size.height / 7,
                    left: size.width / 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 60,
                      backgroundImage: state.image != null
                          ? FileImage(File(state.image!))
                          : Image.asset('imagens/logoEd.png').image,
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.13,
                    child: IconButton(
                      onPressed: () async {
                        await state.loadData();
                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Editar Perfil'),
                              content: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.black,
                                backgroundImage: state.image != null
                                    ? FileImage(File(state.image!))
                                    : Image.asset('imagens/logoEd.png').image,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      state.listProfile.isEmpty
                                          ? await state.insert()
                                          : state.update();
                                      Get.back();
                                    },
                                    child: const Text('atualizar')),
                                IconButton(
                                  onPressed: () async {
                                    if (state.userpro != null) {
                                      state.updateProfile(state.userpro!);
                                      await state.pickImage();
                                      await state.loadData();
                                    } else {
                                      await state.pickImage();
                                    }
                                  },
                                  icon: const Icon(Icons.edit),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.photo_library_outlined),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.40,
                    left: size.width / 14,
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
