import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/autonomy_data.dart';
import '../repositorio_de_dados/person_controler.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amber,
      body: Form(
        key: state.formKey,
        child: Center(
          child: Container(
            width: 340,
            height: 440,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(90),
                  topLeft: Radius.circular(90)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    ' Entrar',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                BaseForm(
                  truee: false,
                  controler: state.controllerCnpj,
                  labelText: 'CNPJ',
                  hintText: 'Informe seu CNPJ',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 18) {
                      return 'Por favor, informe um CNPJ válido.';
                    }
                    return null;
                  },
                  formatter: '###.###.###.###-##',
                ),
                BaseForm(
                  controler: state.controllerSenha,
                  labelText: 'Senha',
                  hintText: 'Informe sua Senha',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Por favor, informe uma senha válida.';
                    }
                    return null;
                  },
                  truee: true,
                  formatter: '',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final username = state.controllerCnpj.text;
                          final password = state.controllerSenha.text;
                          final user = await state.getUserByUsername(username);
                          await state.saveUserInfo(
                              user.id, user.nomeloja, username);
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.wifi &&
                              context.mounted) {
                            if (state.formKey.currentState!.validate()) {
                              if (user != null &&
                                  user.senha == password &&
                                  context.mounted) {
                                state.controllerCnpj.clear();
                                state.controllerSenha.clear();
                                // pega os dasdos da autonomia de acordo com
                                // o id logado
                                final autonomyProvider =
                                    Provider.of<AutonomyProvider>(context,
                                        listen: false);

                                await state.dataAutonomy(user.id);

                                final autonomyDataList =
                                    autonomyProvider.userAutonomyList;
                                if (autonomyDataList != null &&
                                    context.mounted) {
                                  await Get.toNamed('/Homepage');
                                }
                              } else {
                                CustomDialog.showSuccess(
                                    context,
                                    'Erro de Login',
                                    'CNPJ ou senha incorretos.');
                              }
                            }
                          } else if (connectivityResult ==
                              ConnectivityResult.none) {
                            CustomDialog.showSuccess(context, 'Sem Internet',
                                'Você não possui conexão de rede.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Borda arredondada
                          ),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
  }
}
