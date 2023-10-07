import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../repositorio_de_dados/person_controler.dart';
import '../repositorio_de_dados/vehicle_controller.dart';
import '../widgets/autocomplite.dart';
import '../widgets/button_navigation.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';
import '../widgets/image_list.dart';

class VehicleRegister extends StatefulWidget {
  const VehicleRegister({super.key});

  @override
  State<VehicleRegister> createState() => _VehicleRegisterState();
}

class _VehicleRegisterState extends State<VehicleRegister> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context);
    final userid = state.loggedUser!.id;
    final userName = state.loggedUser!.nomeloja;
    return ChangeNotifierProvider<VehicleController>(
        create: (context) =>
            VehicleController(person: userid!, nameUser: userName!),
        child: Consumer<VehicleController>(
          builder: (_, state, __) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.amber,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      await Future.delayed(const Duration(milliseconds: 600),
                          () {
                        Get.offAndToNamed('/Homepage');
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                backgroundColor: Colors.amber,
                body: SingleChildScrollView(
                  child: Center(
                      child: Container(
                    width: 340,
                    height: 850,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                        key: state.formkey,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Cadastrar Veiculo',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _BrandTextField(),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _ModelTextField(),
                            ),
                            BaseForm(
                              formatter: '##/##/####',
                              truee: false,
                              controler: state.controllerYearManufacture,
                              labelText: ' Data de fabricaçao',
                              hintText: 'xx/xx/xxxx',
                              keyboardType: TextInputType.datetime,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 10),
                            ),
                            BaseForm(
                              truee: false,
                              controler: state.controlleryearVehicle,
                              labelText: ' Placa do veiculo',
                              hintText: 'Ex:QQU8H23',
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 10),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: state.controllerImage != null
                                  ? const PhotosList()
                                  : Container(),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: _ChooseOrTakePhoto(),
                            ),
                            BaseForm(
                              truee: false,
                              controler: state.controllerPricePaidShop,
                              labelText: 'Preço do veiculo',
                              hintText: '\$ 000.00',
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 10),
                            ),
                            BaseForm(
                              formatter: '##/##/####',
                              truee: false,
                              controler: state.controllerPurchaseDate,
                              labelText: 'Data da Compra',
                              hintText: 'xx/xx/xxxx',
                              keyboardType: TextInputType.datetime,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 10),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (state.formkey.currentState!
                                          .validate()) {
                                        await state.insert();
                                        state.clearcontroller();
                                        if (context.mounted) {
                                          CustomDialog.showSuccess(
                                              context,
                                              ' ',
                                              'Cadastro do veiculo concluido'
                                                  ' com sucesso !');
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
                          ],
                        ),
                      ),
                    ]),
                  )),
                ));
          },
        ));
  }
}

class _BrandTextField extends StatelessWidget {
  const _BrandTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Este campo é obrigatório.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleController>(context, listen: true);
    return AppTextFieldAutoComplete(
      labeltext: ' marca do carro',
      controller: state.controllerbrand,
      validator: validator,
      focusNode: state.brandFieldFocusNode,
      suggestions: state.allBrands,
    );
  }
}

class _ModelTextField extends StatelessWidget {
  const _ModelTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Este campo é obrigatório.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleController>(context, listen: true);
    return AppTextFieldAutoComplete(
      labeltext: ' Modelo do carro',
      controller: state.constrollermodel,
      validator: validator,
      suggestions: state.allModels,
    );
  }
}

class _ChooseOrTakePhoto extends StatelessWidget {
  const _ChooseOrTakePhoto();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleController>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Buttonnavigator(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Performace visual',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Para melhor performace visual evite fotos com fundo\n\n'
                    'Dica : Va para um editor de foto e retire o fundo '
                    'caso queria \n\n'
                    'Exemplo de Editor web : romove.bg',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await state.pickImage();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('continuar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('cancelar'),
                    ),
                  ],
                );
              },
            );
          },
          text: 'Abrir Galeria',
        ),
        Buttonnavigator(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Performace visual',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Para melhor performace visual evite fotos com fundo \n\n'
                    'Dica : Va para um editor de foto e retire o fundo '
                    'caso queria \n\n'
                    'Exemplo de Editor web : romove.bg',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await state.takePhoto();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('continuar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('cancelar'),
                    ),
                  ],
                );
              },
            );
          },
          text: 'Abrir camera',
        ),
      ],
    );
  }
}
