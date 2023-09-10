import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';
import '../entidades/person.dart';
import '../repositorio_de_dados/autonomy_level_controller.dart';
import '../widgets/card_form_autonomy.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';

class Autonomyedite extends StatelessWidget {
  const Autonomyedite({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Settingscode();
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    return ChangeNotifierProvider(create: (context) {
      return AutonomilevelControler(person: person ?? Person());
    }, child: Consumer<AutonomilevelControler>(
      builder: (_, state, __) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Center(
              child: Text('Cadastro de Autonomia'),
            ),
            leading: IconButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed('/Registerpeople'),
                icon: const Icon(Icons.arrow_back_sharp)),
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
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(70))),
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
                      key: state.formkey,
                      child: Column(
                        children: [
                          BaseForm(
                            truee: false,
                            controler: state.controllerNameNivel,
                            labelText: 'nivel do usuario',
                            hintText: 'EX :iniciante ,intermediario, Avançado'
                                ' e especial',
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 20),
                            keyboardType: TextInputType.name,
                          ),
                          BaseForm(
                            truee: false,
                            controler: state.controllerStorePercentag,
                            labelText: 'Pecentual de ganho da matriz',
                            hintText: 'EX: 74.0 ,79.0 ,84.0 ,94.0',
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 5),
                            keyboardType: TextInputType.number,
                          ),
                          BaseForm(
                            truee: false,
                            controler: state.controllerNetworkPercentage,
                            labelText: 'Percentual de ganho da rede',
                            hintText: 'EX: 25%, 20%, 15%, 5%  ',
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 5),
                            keyboardType: TextInputType.number,
                          ),
                          BaseForm(
                            truee: false,
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
                                    if (state.formkey.currentState!
                                        .validate()) {
                                      state.insert();
                                      if (context.mounted) {
                                        CustomDialog.showSuccess(
                                            context,
                                            ' Autonomia Cadastrada',
                                            'Cadastro finalizado '
                                                'com sucesso!');
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Cadastrar'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(80.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Nome : ${person!.nomeloja}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        CardFormAutonomy(
                                            'Nivel', state.controllerNameNivel),
                                        CardFormAutonomy(
                                            'Porcentagem da matriz',
                                            state.controllerStorePercentag),
                                        CardFormAutonomy('Porcentagem da rede',
                                            state.controllerNetworkPercentage),
                                        CardFormAutonomy('caixa de segurança',
                                            state.controllerNetworkSecurity),
                                      ],
                                    ),
                                  ),
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
        );
      },
    ));
  }
}
