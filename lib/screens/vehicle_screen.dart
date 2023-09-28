import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/form_validator.dart';
import '../entidades/vehicle.dart';
import '../repositorio_de_dados/vehicle_controller.dart';
import '../widgets/autocomplite.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';
import 'botton_navigator_bar.dart';

class VehicleRegister extends StatefulWidget {
  const VehicleRegister({super.key});

  @override
  State<VehicleRegister> createState() => _VehicleRegisterState();
}

class _VehicleRegisterState extends State<VehicleRegister> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Vehicle?;

    return ChangeNotifierProvider<VehicleController>(
        create: (context) => VehicleController(
              vehicle: arguments,
            ),
        child: Consumer<VehicleController>(
          builder: (_, state, __) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.amber,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const Homepage()),
                      );
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
                              formatter: '#######',
                              truee: false,
                              controler: state.controlleryearVehicle,
                              labelText: ' Placa do veiculo',
                              hintText: 'Ex:QQU8H23',
                              keyboardType: TextInputType.datetime,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 10),
                            ),
                            //////////// image
                            BaseForm(
                              formatter: '###.###.###',
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
