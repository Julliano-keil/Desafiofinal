import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/form_validator.dart';
import '../repositorio_de_dados/sales_controller.dart';
import '../widgets/dialog.dart';
import '../widgets/form_pagelogs.dart';

class SaleVehicle extends StatelessWidget {
  const SaleVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final vehicle = arguments['args'];
    final person = arguments['args1'];

    return ChangeNotifierProvider<SaleController>(
      create: (context) => SaleController(vehicle: vehicle, person: person),
      child: Consumer<SaleController>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              elevation: 0,
              leading: IconButton(
                onPressed: () async {
                  await Navigator.of(context)
                      .pushReplacementNamed('/Homepage', arguments: person);
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
                child: AnimatedContainer(
                  width: 340,
                  height: 750,
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
                  duration: const Duration(milliseconds: 5),
                  child: Column(
                    children: [
                      Form(
                        key: state.formkey,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                ' Inscrever-se',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
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
                                truee: false,
                                controler: state.custumerName,
                                labelText: 'Nome do cliente',
                                hintText:
                                    'Nome deve conter no maximo 120 caracteres',
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FormValidator.validateEmpty(value, 20)),
                            BaseForm(
                                formatter: '##/##/####',
                                truee: false,
                                controler: state.soldwhen,
                                labelText: ' Data atual',
                                hintText: '##/##/####',
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FormValidator.validateEmpty(value, 20)),
                            BaseForm(
                                truee: false,
                                controler: state.priceSold,
                                labelText: ' Valor pago',
                                hintText: 'Ex: R\$ 0.000',
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FormValidator.validateEmpty(value, 20)),
                            BaseForm(
                                truee: false,
                                controler: state.bussinessPercetenge,
                                labelText: 'Porcentagem da loja',
                                hintText: 'Senha com 8 digitos',
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FormValidator.validateEmpty(value, 20)),
                            BaseForm(
                                truee: false,
                                controler: state.dealershipPercentage,
                                labelText: ' Porcentagem da rede',
                                hintText: 'Senha com 8 digitos',
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FormValidator.validateEmpty(value, 20)),
                            BaseForm(
                                truee: false,
                                controler: state.safetyPercentage,
                                labelText: ' Caixa de segurança',
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
                                      if (state.formkey.currentState!
                                          .validate()) {
                                        await state.insert();
                                        if (context.mounted) {
                                          CustomDialog.showSuccess(
                                              context,
                                              '',
                                              'Venda realizada com  '
                                                  'sucesso !');
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
