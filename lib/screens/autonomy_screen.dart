import 'dart:async';

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
                onPressed: () async => Navigator.of(context,
                        rootNavigator: true)
                    .pushReplacementNamed('/Registerpeople', arguments: person),
                icon: const Icon(Icons.arrow_back_sharp)),
            centerTitle: true,
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
                          _Dropdown(controller: state.controllerNameNivel),
                          BaseForm(
                            formatter: '##.###',
                            truee: false,
                            controler: state.controllerStorePercentag,
                            labelText: 'Pecentual de ganho da matriz',
                            hintText: 'EX: 74.0 ,79.0 ,84.0 ,94.0',
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 5),
                            keyboardType: TextInputType.number,
                          ),
                          BaseForm(
                            formatter: '##.###',
                            truee: false,
                            controler: state.controllerNetworkPercentage,
                            labelText: 'Percentual de ganho da rede',
                            hintText: 'EX: 25%, 20%, 15%, 5%  ',
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 5),
                            keyboardType: TextInputType.number,
                          ),
                          BaseForm(
                            formatter: '##.###',
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
                                      unawaited(state.insert());
                                      if (context.mounted &&
                                          state.listaAutonomy.isEmpty) {
                                        CustomDialog.showSuccess(
                                            context,
                                            ' Autonomia Cadastrada',
                                            'Cadastro finalizado '
                                                'com sucesso!');
                                      } else {
                                        CustomDialog.showSuccess(
                                            context,
                                            ' Autonomia já Cadastrada',
                                            'Em caso de alteraçao '
                                                'Va para aba de alterar '
                                                'autonomia');
                                        state.cleanController();
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Cadastrar Nivel'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(80.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.9),
                                        spreadRadius: 6,
                                        blurRadius: 13,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
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

class _Dropdown extends StatefulWidget {
  const _Dropdown({required this.controller});

  final TextEditingController controller;
  @override
  State<_Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<_Dropdown> {
  final List<String> _items = [
    'Iniciante',
    'Intermediario',
    'Avançado',
    'Especial'
  ];
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedItem,
                items: _items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return _items.map<Widget>((item) {
                    return Text(
                      item,
                      style: const TextStyle(
                        color:
                            Colors.white, // Define a cor do texto selecionado
                        fontSize: 18,
                      ),
                    );
                  }).toList();
                },
                style: const TextStyle(
                  color: Colors
                      .black, // Define a cor do texto selecionado quando a lista está aberta
                  fontSize: 20,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                    value = widget.controller.text;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Escolha uma Autonomia',
                    hintStyle: TextStyle(color: Colors.white),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
