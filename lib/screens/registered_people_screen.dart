import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/settings_code.dart';
import '../data_repositories/signup_controller.dart';
import '../entidades/person.dart';
import '../reusable widgets/dialog.dart';
import 'registered_autonomy_screen.dart';

///class responsible for editing, changing and deleting the registered user,
/// and also has a list of the user's level card
class Registeredpeople extends StatelessWidget {
  ///cosntructor class
  const Registeredpeople({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settingscode>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async => Get.back(),
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,
        title: const Text('Associados'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
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
                        bottomRight: Radius.circular(200))),
                //
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
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(150))),
                ),
              ),
            ),
            _RegisteredList(),
          ],
        ),
      ),
    );
  }
}

class _RegisteredList extends StatefulWidget {
  @override
  State<_RegisteredList> createState() => _RegisteredListState();
}

class _RegisteredListState extends State<_RegisteredList> {
  bool _status = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SignUpController>(
      create: (context) => SignUpController(),
      child: Consumer<SignUpController>(
        builder: (_, state, __) {
          return ListView.builder(
            itemCount: state.listaPeople.length,
            itemBuilder: (context, index) {
              final person = state.listaPeople[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      shadowColor: Colors.purple,
                      child: AnimatedCard(
                        direction: AnimatedCardDirection.left,
                        initDelay: const Duration(milliseconds: 2),
                        duration: const Duration(seconds: 1),
                        onRemove: () async {
                          if (person.id != 1) {
                            CustomDialog.showSuccess(
                                context, 'Ecluido ', 'Usuario Excluido');

                            await state.delete(person);
                          } else {
                            CustomDialog.showSuccess(
                                context,
                                ' ',
                                'Nao é possivel excluir'
                                    ' o usuario ${person.storeName}');
                            await state.loadata();
                          }
                        },
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              ListTile(
                                trailing: PopupMenuButton<String>(
                                  onSelected: (choice) async {
                                    if (choice == 'Opção 1') {
                                      await Get.toNamed('/Autonomyedite',
                                          arguments: person);
                                    } else if (choice == 'Opção 2') {
                                      Get.snackbar('Informaçao',
                                          'Popule o formulario para editar');
                                      await Get.toNamed('/EditPerson',
                                          arguments: person);
                                    } else if (choice == 'Opção 4') {
                                      setState(
                                        () {
                                          _status = !_status;
                                        },
                                      );
                                    }
                                    if (choice == 'Opção 5') {
                                      debugPrint('not');
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'Opção 1',
                                        child: Text('Cadastrar nivel'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'Opção 2',
                                        child: Text('Editar Usuario'),
                                      ),
                                      person.id == 1
                                          ? const PopupMenuItem<String>(
                                              value: 'Opção 4',
                                              child: Text(
                                                  'Editar ou deletar nivel'),
                                            )
                                          : const PopupMenuItem<String>(
                                              value: 'Opção 3',
                                              child: Text('Deletar'),
                                            ),
                                    ];
                                  },
                                ),
                                title: Text(
                                  person.storeName.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                subtitle:
                                    Text('Cnpj: ${person.cnpj.toString()}'),
                              ),
                              Visibility(
                                visible: !_status,
                                maintainSize: false,
                                maintainAnimation: true,
                                maintainState: true,
                                child: RegisteredListAutonomy(person: person),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// delete user
class DeleteUser {
  ///method that creates dialogue with text
  static void showSuccess(BuildContext context,
      {required String primarytext,
      required String secondtext,
      required Function() onRemove,
      required Person person}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Deletar ⚠️',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Deseja mesmo apagar o'
            ' usuario(a) ${person.storeName} ?',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (context.mounted) {
                  Get.back();
                }
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
