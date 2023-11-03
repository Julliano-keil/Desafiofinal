import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../casos_de_usos/form_validator.dart';
import '../casos_de_usos/settings_code.dart';
import '../data_repositories/person_controler.dart';
import '../data_repositories/sales_controller.dart';
import '../entidades/vehicle.dart';
import '../reusable widgets/form_pagelogs.dart';

///class responsible for registering car sales
class SaleVehicle extends StatelessWidget {
  ///constructor class
  const SaleVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle?;
    final state = Provider.of<PersonControler>(context, listen: true);
    final userid = state.loggedUser!.id;
    final userName = state.loggedUser!.storeName;
    final userCnpj = state.loggedUser!.cnpj;
    final settings = Provider.of<Settingscode>(context);
    return ChangeNotifierProvider<SaleController>(
      create: (context) => SaleController(
        vehicle: vehicle!,
        person: userid!,
        nameUser: userName!,
        brand: vehicle.brand,
        model: vehicle.model,
        userCnpj: userCnpj!,
        plate: vehicle.yearVehicle,
      ),
      child: Consumer<SaleController>(
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
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              dragStartBehavior: DragStartBehavior.start,
              padding: const EdgeInsets.only(top: 90),
              physics: const ClampingScrollPhysics(),
              primary: isBlank,
              child: Center(
                child: Form(
                  key: state.formkey,
                  child: Container(
                    width: 350,
                    height: 570,
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              ' Vender veiculo',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                          BaseForm(
                            formatter: '###.###.###-##',
                            controler: state.customerCpf,
                            labelText: 'CPF',
                            hintText: 'Informe seu CPF',
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 18),
                            truee: false,
                          ),
                          BaseForm(
                            controler: state.custumerName,
                            labelText: 'Nome do cliente',
                            hintText:
                                'Nome deve conter no maximo 120 caracteres',
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                FormValidator.validateEmpty(value, 20),
                            truee: false,
                          ),
                          BaseForm(
                              formatter: '##/##/####',
                              truee: false,
                              controler: state.soldwhen,
                              labelText: ' Data atual',
                              hintText: '##/##/####',
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 20)),
                          BaseForm(
                              truee: false,
                              controler: state.priceSold,
                              labelText: ' Valor pago',
                              hintText: 'Valor atual do veiculo'
                                  ' \$ ${vehicle!.pricePaidShop}',
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  FormValidator.validateEmpty(value, 20)),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await state.dataAutonomy(userid!);
                                    if (state.autonomydataAnali) {
                                      if (state.formkey.currentState!
                                          .validate()) {
                                        await state.insert();
                                        if (state.autonomydataAnali &&
                                            context.mounted) {
                                          await QuickAlert.show(
                                            headerBackgroundColor: Colors.black,
                                            autoCloseDuration:
                                                const Duration(seconds: 5),
                                            context: context,
                                            type: QuickAlertType.loading,
                                            title: 'Cadastrando venda',
                                          );
                                        }
                                      }
                                    } else {
                                      Get.snackbar('Informaçao',
                                          'autonomia nao cadastrada');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Cadastrar Venda',
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
