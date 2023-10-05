import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';
import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';
import '../repositorio_de_dados/autonomy_level_controller.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';
import 'registered_people_screen.dart';

class SalesReport extends StatelessWidget {
  SalesReport({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Registeredpeople(),
          )),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Autonomias'),
        ),
      ),
      body: AnimatedContainer(
        width: double.infinity,
        height: double.infinity,
        color: color.cor,
        duration: const Duration(seconds: 2),
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
            SalesReportScreen(
              person: person ?? Person(),
            )
          ],
        ),
      ),
    );
  }
}

class SalesReportScreen extends StatelessWidget {
  Person person;

  SalesReportScreen({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AutonomilevelControler(person: person);
      },
      child: Consumer<AutonomilevelControler>(
        builder: (_, state, __) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.listaAutonomy.length,
            itemBuilder: (context, index) {
              final autonomy = state.listaAutonomy[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  child: Card(
                    color: Colors.white,
                    elevation: 45,
                    child: ListTile(
                      trailing: PopupMenuButton<String>(
                        onSelected: (choice) async {
                          if (choice == 'Opção 2') {
                            await Navigator.of(context, rootNavigator: true)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => EditAutonomy(
                                person: person,
                                autonomy: autonomy,
                              ),
                            ));
                            if (context.mounted) {
                              CustomDialog.showSuccess(
                                  context,
                                  ' ',
                                  'Popule (🖋️)o formulario'
                                      ' para alterar');
                            }
                          } else if (choice == 'Opção 3' && person.id != 1) {
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
                                  content: const Text(
                                    'Deseja mesmo apagar o nivel '
                                    ' de usuario ?',
                                    style: TextStyle(
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
                          } else {
                            CustomDialog.showSuccess(
                                context,
                                '⚠️',
                                'O Nivel do usuario ${person.nomeloja}'
                                    ' nao pode ser excluido');
                          }
                        },
                        itemBuilder: (context) {
                          return <PopupMenuEntry<String>>[
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
                        'Nivel do(a) ${person.nomeloja.toString()}',
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

class EditAutonomy extends StatelessWidget {
  EditAutonomy({super.key, required this.autonomy, required this.person});

  final Settingscode color = Settingscode();
  final AutonomyLevel autonomy;
  final Person person;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AutonomilevelControler>(
      create: (context) => AutonomilevelControler(person: person),
      child: Consumer<AutonomilevelControler>(
        builder: (_, state, __) {
          return Scaffold(
              backgroundColor: Colors.amber,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.amber,
                leading: IconButton(
                    onPressed: () async {
                      await Navigator.of(context).pushReplacementNamed(
                          '/Registerpeople',
                          arguments: person);
                    },
                    icon: const Icon(Icons.arrow_back_outlined)),
                title: Center(
                  child: Text(
                    'Nivel do(a) ${person.nomeloja}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              body: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      width: 350,
                      height: 600,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(90),
                            topLeft: Radius.circular(90)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 6,
                            blurRadius: 13,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        Form(
                          key: state.formkey,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Text(
                                  ' Editar Usuario',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                              BaseForm(
                                controler: state.controllerNameNivel,
                                labelText: 'Nivel',
                                hintText:
                                    'EX :iniciante ,intermediario, Avançado',
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FormValidator.validateEmpty(value, 14),
                                truee: false,
                              ),
                              BaseForm(
                                  formatter: '##.###',
                                  truee: false,
                                  controler: state.controllerStorePercentag,
                                  labelText: 'Porcentagem da loja',
                                  hintText: 'EX: 74.0 ,79.0 ,84.0 ,94.0',
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      FormValidator.validateEmpty(value, 20)),
                              BaseForm(
                                  formatter: '###.###.###.###-##',
                                  truee: false,
                                  controler: state.controllerNetworkPercentage,
                                  labelText: ' Percentual de ganho da rede',
                                  hintText: 'EX: 25%, 20%, 15%, 5%',
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      FormValidator.validateEmpty(value, 20)),
                              BaseForm(
                                  formatter: '###.###.###.###-##',
                                  truee: false,
                                  controler: state.controllerNetworkSecurity,
                                  labelText: ' caixa de segurança',
                                  hintText: 'Recomendado minimo de 1%9',
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      FormValidator.validateEmpty(value, 20)),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await state.update();

                                        if (context.mounted) {
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                  'usuario(a)'
                                                  ' ${person.nomeloja}'
                                                  ' alterado com sucesso ?',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      if (context.mounted) {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text(
                                                      'ok',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text('Cadastrar',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    IconButton.filled(
                                        onPressed: () =>
                                            state.updatePerson(autonomy),
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.amber,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
