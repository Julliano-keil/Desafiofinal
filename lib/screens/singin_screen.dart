import 'package:flutter/material.dart';
import 'package:jscar/repositorio_de_dados/person_controler.dart';

import 'package:provider/provider.dart';
import '../widgets/form_pagelogs.dart';
import 'botton_navigator_bar.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => PersonControler(),
        child: Consumer<PersonControler>(
          builder: (_, state, __) {
            state.loadata();
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.amber,
              ),
              backgroundColor: Colors.amber,
              body: Center(
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
                          if (value == null || value.isEmpty) {
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
                          if (value == null || value.isEmpty) {
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Homepage()));
                              },
                              child: const Text('Entrar'),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            'Esqueci minha Senha ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
