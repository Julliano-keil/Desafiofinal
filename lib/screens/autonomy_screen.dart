import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';
import '../repositorio_de_dados/autonomy_level.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';
import 'maindrawer.dart';

class Autonomyedite extends StatelessWidget {
  const Autonomyedite({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AutonomilevelControler>(context, listen: true);
    final color = Settingscode();
    final formkey = GlobalKey<FormState>();

    return MaterialApp(
      home: Scaffold(
        drawer:
            const MainDrawer(), //                                     <= drawer
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text('Cadastro de Autonomia'),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: color.cor,
          child: Stack(
            children: [
              Container(
                color: Colors.amber,
                width: 430,
                height: 400,
                child: Container(
                  width: 420,
                  height: 382,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(70))),
                  //
                ),
              ),
              Positioned(
                top: 400,
                child: Container(
                  color: Colors.black,
                  width: 430,
                  height: 411,
                  child: Container(
                    width: 420,
                    height: 400,
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(350))),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        BaseForm(
                          controler: state.controllerNameNivel,
                          labelText: 'nivel do usuario',
                          hintText: 'EX :iniciante ,intermediario, Avançado'
                              ' e especial',
                          validator: (value) =>
                              FormValidator.validateEmpty(value, 20),
                          keyboardType: TextInputType.name,
                        ),
                        BaseForm(
                          controler: state.controllerStorePercentag,
                          labelText: 'Pecentual de ganho da matriz',
                          hintText: 'EX: 74.0 ,79.0 ,84.0 ,94.0',
                          validator: (value) =>
                              FormValidator.validateEmpty(value, 5),
                          keyboardType: TextInputType.number,
                        ),
                        BaseForm(
                          controler: state.controllerNetworkPercentage,
                          labelText: 'Percentual de ganho da rede',
                          hintText: 'EX: 25%, 20%, 15%, 5%  ',
                          validator: (value) =>
                              FormValidator.validateEmpty(value, 5),
                          keyboardType: TextInputType.number,
                        ),
                        BaseForm(
                          controler: state.controllerNetworkSecurity,
                          labelText: 'caixa de segurança',
                          hintText: 'Recomendado minimo de 1%',
                          validator: (value) =>
                              FormValidator.validateEmpty(value, 5),
                          keyboardType: TextInputType.number,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    state.insert();
                                    if (context.mounted) {
                                      CustomDialog.showSuccess(
                                          context,
                                          ' Autonomia Cadastrada',
                                          'Cadastro finalizado com sucesso!');
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Borda arredondada
                                  ),
                                ),
                                child: const Text('Cadastrar'),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
