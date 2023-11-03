import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';

import '../data_repositories/signup_controller.dart';
import '../entidades/person.dart';

import '../reusable widgets/form_pagelogs.dart';

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
              title: const Text(
                'Editar Usuarios',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: state.formKey,
              child: Center(
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
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () async {
                              await state.pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: state.controllerImage != null
                                  ? FileImage(File(state.controllerImage!))
                                  : Image.asset('imagens/logoEd.png').image,
                              radius: 40,
                            ),
                          )),
                      BaseForm(
                        formatter: '##.###.###/####-##',
                        controler: state.controllerCnpj,
                        labelText: 'CNPJ',
                        hintText: 'Informe seu CNPJ',
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            FormValidator.validateEmpty(value, 14),
                        truee: false,
                      ),
                      BaseForm(
                          truee: false,
                          controler: state.controllerName,
                          labelText: 'Nome da Loja',
                          hintText: 'Nome da loja entre 120 caracteres',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              FormValidator.validateEmpty(value, 20)),
                      BaseForm(
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await state.update();
                                await state.loadata();
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              if (context.mounted) {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text(
                                              'ok',
                                              style: TextStyle(fontSize: 20),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Alterar',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            IconButton.filled(
                              onPressed: () => state.updatePerson(person!),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
