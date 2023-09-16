import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../repositorio_de_dados/vehicle_controller.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';
import 'botton_navigator_bar.dart';

class VehicleRegister extends StatelessWidget {
  const VehicleRegister({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VehicleController>(
        create: (context) => VehicleController(),
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
                            BaseForm(
                              controler: state.constrollermodel,
                              labelText: 'Modelo',
                              hintText: 'Modelo do carro',
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 15),
                              truee: false,
                            ),
                            BaseForm(
                              truee: false,
                              controler: state.controllerbrand,
                              labelText: 'Marca',
                              hintText: '',
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 15),
                            ),
                            BaseForm(
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
                              labelText: ' Data do veiculo',
                              hintText: 'xx/xx/xxxx',
                              keyboardType: TextInputType.datetime,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 10),
                            ),
                            BaseForm(
                              truee: false,
                              controler: state.controllerImage,
                              labelText: ' foto do veiculo',
                              hintText: 'xx/xx/xxxx',
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 10),
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
