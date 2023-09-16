import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../entidades/person.dart';
import '../repositorio_de_dados/list_autonomy_controller.dart';

class RegisteredListAutonomy extends StatelessWidget {
  const RegisteredListAutonomy({super.key});

  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    return ChangeNotifierProvider(create: (context) {
      return ListAutonomyController(person: person ?? Person());
    }, child: Consumer<ListAutonomyController>(builder: (_, state, __) {
      return ListView.builder(
        itemCount: state.listaAutonomy.length,
        itemBuilder: (context, index) {
          final autonomy = state.listaAutonomy[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              child: Card(
                color: Colors.white,
                elevation: 14,
                child: ListTile(
                  trailing: PopupMenuButton<String>(
                    onSelected: (choice) async {
                      if (choice == 'Opção 2') {
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacementNamed('/EditPerson',
                                arguments: autonomy);
                      } else if (choice == 'Opção 3') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Deletar ⚠️',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                'Deseja mesmo apagar o'
                                ' usuario ${autonomy.name} ?',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await state.delete(autonomy);
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
                          child: Text('Editar Nivel'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Opção 3',
                          child: Text('Deletar Usuario'),
                        ),
                      ];
                    },
                  ),
                  title: Text(
                    autonomy.personID.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(autonomy.name),
                ),
              ),
            ),
          );
        },
      );
    }));
  }
}
