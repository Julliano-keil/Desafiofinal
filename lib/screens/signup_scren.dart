import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';
import '../data_repositories/signup_controller.dart';
import '../reusable widgets/form_pagelogs.dart';
import 'registered_people_screen.dart';

///class responsible for collecting information from
///a new user and registering it in the database
class SignUp extends StatelessWidget {
  ///constructor class
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final settings = Provider.of<Settingscode>(context);
    return ChangeNotifierProvider<SignUpController>(
      create: (context) => SignUpController(),
      child: Consumer<SignUpController>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: settings.ligthMode ? Colors.amber : Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await Future.delayed(
                      const Duration(milliseconds: 400), Get.back);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: settings.ligthMode ? Colors.amber : Colors.white,
            body: Form(
              key: state.formKey,
              child: Center(
                child: Container(
                  width: 340,
                  height: 460,
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
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          ' Inscrever-se',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      BaseForm(
                        formatter: '##.###.###/####-##',
                        controler: state.controllerCnpj,
                        labelText: 'CNPJ',
                        hintText: 'Informe seu CNPJ',
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            FormValidator.validateEmpty(value, 18),
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
                      Stack(
                        children: [
                          BaseForm(
                              truee: false,
                              controler: state.controllerSenha,
                              labelText: ' Senha',
                              hintText: 'Senha com 8 digitos',
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 20)),
                          Positioned(
                            top: size.height / 70,
                            left: size.width * 0.65,
                            child: IconButton(
                                onPressed: () => state.password(),
                                icon: const Icon(
                                  Icons.password,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (state.formKey.currentState!.validate()) {
                                  Get.snackbar(
                                      'Informaçao',
                                      'Voce sera redirecionado '
                                          'automaticamente para cadastrar'
                                          ' a autonomia do usuario');

                                  await state.insert();
                                  await _goListPage();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Cadastrar',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
        },
      ),
    );
  }
}

Future<void> _goListPage() async {
  await Future.delayed(
    const Duration(seconds: 3),
    () {
      Get.to(
        const Registeredpeople(),
      );
    },
  );
}
