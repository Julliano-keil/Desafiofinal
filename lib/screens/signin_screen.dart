// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositorio_de_dados/person_controler.dart';
import '../widgets/form_pagelogs.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final state = Provider.of<PersonControler>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amber,
      body: Form(
        key: formKey,
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
                  controler: state.controllerCnpj,
                  labelText: 'CNPJ',
                  hintText: 'Informe seu CNPJ',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 14) {
                      return 'Por favor, informe um CNPJ válido.';
                    }
                    return null;
                  },
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
                          if (formKey.currentState!.validate()) {
                            if (user != null && user.senha == password) {
                              await Navigator.of(context)
                                  .pushReplacementNamed('/Homepage');
                            } else {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Erro de Login'),
                                    content:
                                        const Text('CNPJ ou senha incorretos.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: const Text('Entrar'),
                      ),
                      const Center(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.white),
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
