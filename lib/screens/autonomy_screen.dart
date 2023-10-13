import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';
import '../entidades/person.dart';
import '../repositorio_de_dados/autonomy_level_controller.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';

///class responsible for editing user autonomy
class Autonomyedite extends StatelessWidget {
  /// constructor class
  const Autonomyedite({super.key});

  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    final settings = Provider.of<Settingscode>(context);
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
                onPressed: () async => Get.back(),
                icon: const Icon(Icons.arrow_back_sharp)),
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: settings.ligthMode ? Colors.amber : Colors.white,
            child: Stack(
              children: [
                Container(
                  color: Colors.black,
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
                      decoration: BoxDecoration(
                          color:
                              settings.ligthMode ? Colors.amber : Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(350))),
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
                            controler: state.controllerStorePercentage,
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
                                          'Nome : ${person!.storeName}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        _CardFormAutonomy(
                                            'Nivel', state.controllerNameNivel),
                                        _CardFormAutonomy(
                                            'Porcentagem da matriz',
                                            state.controllerStorePercentage),
                                        _CardFormAutonomy('Porcentagem da rede',
                                            state.controllerNetworkPercentage),
                                        _CardFormAutonomy('caixa de segurança',
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
                selectedItemBuilder: (context) {
                  return _items.map<Widget>((item) {
                    return Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    );
                  }).toList();
                },
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                    widget.controller.text = value!;
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

class _CardFormAutonomy extends StatelessWidget {
  final String labelText;
  final TextEditingController? controler;

  const _CardFormAutonomy(this.labelText, this.controler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: false,
        controller: controler,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
          floatingLabelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
