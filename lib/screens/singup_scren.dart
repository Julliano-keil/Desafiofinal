import 'package:flutter/material.dart';
import 'package:jscar/repositorio_de_dados/person_controler.dart';

import 'package:jscar/widgets/form_pagelogs.dart';
import 'package:provider/provider.dart';

import 'botton_navigator_bar.dart';
import 'singin_screen.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PersonControler(),
        child: Consumer<PersonControler>(
          builder: (_, state, __) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              backgroundColor: Colors.amber,
              body: Center(
                child: Container(
                  width: 340,
                  height: 490,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            ' Inscrever-se',
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
                            } else if (value.length < 14 || value.length > 14) {
                              return 'cnpj deve conter 14 digitos';
                            }
                            return null;
                          },
                        ),
                        BaseForm(
                          controler: state.controllerName,
                          labelText: 'Nome da Loja',
                          hintText: 'Nome da loja entre 120 caracteres',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, informe um nome válido.';
                            } else if (value.length > 120) {
                              return 'Nome deve  ter menos de 120 caracteres';
                            }
                            return null;
                          },
                        ),
                        BaseForm(
                          controler: state.controllerSenha,
                          labelText: ' Senha',
                          hintText: 'Senha com 8 digitos',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, informe uma senha válida.';
                            } else if (value.length > 12) {
                              return 'senha deve  ter menos de 12 caracteres';
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
                                  if (_formKey.currentState!.validate()) {
                                    await state.insert();
                                  }
                                },
                                child: const Text('Cadastrar'),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            },
                            child: const Text(
                              'Ja tenho conta ',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
