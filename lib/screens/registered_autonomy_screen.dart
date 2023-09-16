import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/settings_code.dart';
import '../entidades/person.dart';
import '../repositorio_de_dados/autonomy_level_controller.dart';
import 'registered_people_screen.dart';

class RegisteredAutonomy extends StatelessWidget {
  RegisteredAutonomy({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Registeredpeople(),
                )),
            icon: const Icon(Icons.arrow_back_outlined)),
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Autonomias'),
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
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                  ),
                ),
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150),
                    ),
                  ),
                ),
              ),
            ),
            _RegisteredListAutonomy(
              person: person ?? Person(),
            )
          ],
        ),
      ),
    );
  }
}

class _RegisteredListAutonomy extends StatelessWidget {
  const _RegisteredListAutonomy({
    required this.person,
  });

  final Person person;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AutonomilevelControler(person: person);
      },
      child: Consumer<AutonomilevelControler>(
        builder: (_, state, __) {
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
                                .pushReplacementNamed('/EditAutonomy',
                                    arguments: autonomy);
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
                                    ' usuario ${autonomy.name} ?',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                        person.nomeloja.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(autonomy.name),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
