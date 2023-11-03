import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';
import '../data_repositories/person_controler.dart';
import '../reusable widgets/dialog.dart';
import '../reusable widgets/form_pagelogs.dart';

///class responsible for collecting login
///information and ferifying the controller
class SignIn extends StatelessWidget {
  ///constructor class
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settingscode>(context);
    final state = Provider.of<PersonControler>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: settings.ligthMode ? Colors.amber : Colors.white,
      ),
      backgroundColor: settings.ligthMode ? Colors.amber : Colors.white,
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
                  validator: (value) => FormValidator.validateEmpty(value, 18),
                  formatter: '##.###.###/####-##',
                ),
                BaseForm(
                  controler: state.controllerSenha,
                  labelText: 'Senha',
                  hintText: 'Informe sua Senha',
                  keyboardType: TextInputType.text,
                  validator: (value) => FormValidator.validateEmpty(value, 8),
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
                          final userCnpj = state.controllerCnpj.text;
                          final password = state.controllerSenha.text;
                          final user = await state.getUserByUsercnpj(userCnpj);
                          await state.getdate();
                          await state.louddata();
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (state.formKey.currentState!.validate()) {
                            if (context.mounted) {
                              await _handleLogin(
                                  context, user, password, userCnpj);
                            }
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
                      ),
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

Future<void> _handleLogin(BuildContext context, dynamic user, String password,
    String userCnpj) async {
  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.mobile) {
    if (user != null && user.password == password && context.mounted) {
      final state = Provider.of<PersonControler>(context, listen: false);
      state.controllerCnpj.clear();
      state.controllerSenha.clear();
      try {
        await state.saveUserInfo(user.id, user.storeName, userCnpj);
        await state.loadUserInfo();

        await Future.delayed(const Duration(milliseconds: 400), () {
          Get.offAndToNamed('/Homepage');
        });
      } catch (e) {
        CustomDialog.showSuccess(
            context, 'Erro', 'Ocorreu um erro ao fazer login.');
      }
    } else {
      CustomDialog.showSuccess(
          context, 'Erro de Login', 'CNPJ ou senha incorretos.');
    }
  } else if (connectivityResult == ConnectivityResult.none && context.mounted) {
    CustomDialog.showSuccess(
        context, 'Sem Internet', 'Você não possui conexão de rede.');
  }
}
