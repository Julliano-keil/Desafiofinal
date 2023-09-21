import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../repositorio_de_dados/signup_controller.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';
import 'botton_navigator_bar.dart';
import 'registered_people_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  final bool show = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpController>(
        create: (context) => SignUpController(),
        child: Consumer<SignUpController>(builder: (_, state, __) {
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
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              backgroundColor: Colors.amber,
              body: Center(
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
                child: Column(children: [
                  Form(
                    key: state.formKey,
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
                            formatter: '',
                            truee: false,
                            controler: state.controllerName,
                            labelText: 'Nome da Loja',
                            hintText: 'Nome da loja entre 120 caracteres',
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 20)),
                        BaseForm(
                            formatter: '',
                            truee: false,
                            controler: state.controllerSenha,
                            labelText: ' Senha',
                            hintText: 'Senha com 8 digitos',
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 20)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (state.formKey.currentState!.validate()) {
                                    await state.insert();
                                    if (context.mounted) {
                                      CustomDialog.showSuccess(
                                          context,
                                          'Login quase pronto',
                                          'siga os passos abaixo '
                                              'para finalizar !');
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Cadastrar',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text(
                                'Cadastre o nivel do usuario indo para \na '
                                'lista de usuarios cadastrados',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => Registeredpeople(),
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.lock_person_outlined,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )));
        }));
  }
}
