import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/settings_code.dart';
import '../entidades/person.dart';
import '../repositorio_de_dados/signup_controller.dart';
import '../widgets/dialog.dart';
import 'registered_autonomy_screen.dart';

class Registeredpeople extends StatelessWidget {
  Registeredpeople({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async => Navigator.of(context, rootNavigator: true)
                .pushReplacementNamed('/Homepage', arguments: person),
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,
        title: const Text('Associados'),
        centerTitle: true,
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
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(200))),
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
    return ChangeNotifierProvider<SignUpController>(
      create: (context) => SignUpController(),
      child: Consumer<SignUpController>(
        builder: (_, state, __) {
          return ListView.builder(
            itemCount: state.listaPeople.length,
            itemBuilder: (context, index) {
              final person = state.listaPeople[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      color: _status ? Colors.white : Colors.white70,
                      elevation: 14,
                      child: Column(
                        children: [
                          ListTile(
                            trailing: PopupMenuButton<String>(
                              onSelected: (choice) async {
                                if (choice == 'Opção 1') {
                                  await Navigator.of(context,
                                          rootNavigator: true)
                                      .pushReplacementNamed('/Autonomyedite',
                                          arguments: person);
                                } else if (choice == 'Opção 2') {
                                  await Navigator.of(context,
                                          rootNavigator: true)
                                      .pushReplacementNamed('/EditPerson',
                                          arguments: person);
                                  if (context.mounted) {
                                    CustomDialog.showSuccess(
                                        context,
                                        ' ',
                                        'Popule (🖋️)o formulario'
                                            ' para alterar');
                                  }
                                } else if (choice == 'Opção 3' &&
                                    person.id != 1) {
                                  await showDialog(
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
                                  setState(() {
                                    _status = !_status;
                                  });
                                } else {
                                  CustomDialog.showSuccess(
                                      context,
                                      '⚠️',
                                      'O usuario ${person.nomeloja}'
                                          ' nao pode ser excluido');
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
                                          child:
                                              Text('Editar ou deletar nivel'),
                                        )
                                      : const PopupMenuItem<String>(
                                          value: 'Opção 3',
                                          child: Text('Deletar')),
                                ];
                              },
                            ),
                            title: Text(
                              person.nomeloja.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text('Cnpj: ${person.cnpj.toString()}'),
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
