import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';

import '../entidades/person.dart';
import '../repositorio_de_dados/signup_controller.dart';
import '../widgets/form_pagelogs.dart';

///responsible for listing registered vehicles
class EditPerson extends StatelessWidget {
  ///constructor class
  const EditPerson({super.key});

  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    final settings = Provider.of<Settingscode>(context);
    return ChangeNotifierProvider<SignUpController>(
      create: (context) => SignUpController(),
      child: Consumer<SignUpController>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: settings.ligthMode ? Colors.amber : Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: settings.ligthMode ? Colors.amber : Colors.white,
              leading: IconButton(
                onPressed: () async => Get.back(),
                icon: const Icon(Icons.arrow_back_outlined),
                color: Colors.black,
              ),
              title: const Center(
                child: Text(
                  'Editar Usuarios',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              centerTitle: true,
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    width: 340,
                    height: 500,
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
                    child: Column(
                      children: [
                        Form(
                          key: state.formKey,
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
                                formatter: '###.###.###.###-##',
                                controler: state.controllerCnpj,
                                labelText: 'CNPJ',
                                hintText: 'Informe seu CNPJ',
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    FormValidator.validateEmpty(value, 14),
                                truee: false,
                              ),
                              BaseForm(
                                  formatter: '###.###.###.###-##',
                                  truee: false,
                                  controler: state.controllerName,
                                  labelText: 'Nome da Loja',
                                  hintText: 'Nome da loja entre 120 caracteres',
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      FormValidator.validateEmpty(value, 20)),
                              BaseForm(
                                  formatter: '###.###.###.###-##',
                                  truee: false,
                                  controler: state.controllerSenha,
                                  labelText: ' Senha',
                                  hintText: 'Senha com 8 digitos',
                                  keyboardType: TextInputType.text,
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
                                                  ' ${person!.storeName}'
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
                                          state.updatePerson(person!),
                                      icon: Icon(
                                        Icons.edit,
                                        color: settings.ligthMode
                                            ? Colors.amber
                                            : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
