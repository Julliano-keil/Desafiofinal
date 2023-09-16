import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositorio_de_dados/signup_controller.dart';
import 'dialog.dart';

class RegisteredList extends StatelessWidget {
  const RegisteredList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpController>(
        create: (context) => SignUpController(),
        child: Consumer<SignUpController>(builder: (_, state, __) {
          return ListView.builder(
            itemCount: state.listaPeople.length,
            itemBuilder: (context, index) {
              final person = state.listaPeople[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  child: Card(
                    color: Colors.white,
                    elevation: 14,
                    child: ListTile(
                      trailing: PopupMenuButton<String>(
                        onSelected: (choice) async {
                          if (choice == 'Opção 1') {
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacementNamed('/Autonomyedite',
                                    arguments: person);
                          } else if (choice == 'Opção 2') {
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacementNamed('/EditPerson',
                                    arguments: person);
                            CustomDialog.showSuccess(
                                context,
                                ' ',
                                'Popule (🖋️)o formulario'
                                    ' para alterar');
                          } else if (choice == 'Opção 3') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Deletar ⚠️',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(
                                    'Deseja mesmo apagar o'
                                    ' usuario(a) ${person.nomeloja} ?',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await state.delete(person);
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('Sim'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Não'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (choice == 'Opção 4') {
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacementNamed('/RegisteredAutonomy',
                                    arguments: person);
                          }
                        },
                        itemBuilder: (context) {
                          return <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Opção 1',
                              child: Text('Nivel de usuario'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Opção 2',
                              child: Text('Editar Usuario'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Opção 3',
                              child: Text('Deletar Usuario'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Opção 4',
                              child: Text('lista de niveis'),
                            ),
                          ];
                        },
                      ),
                      title: Text(
                        person.nomeloja.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(person.cnpj.toString()),
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}
