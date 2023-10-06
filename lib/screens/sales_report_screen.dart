import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/settings_code.dart';
import '../repositorio_de_dados/person_controler.dart';
import '../repositorio_de_dados/sale_report_controller.dart';

class SalesReport extends StatelessWidget {
  SalesReport({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async => Get.offAndToNamed('/Homepage'),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Relatorios de vendas'),
        ),
      ),
      body: AnimatedContainer(
        width: double.infinity,
        height: double.infinity,
        color: color.cor,
        duration: const Duration(seconds: 2),
        child: Stack(
          children: [
            Container(
              color: color.cor,
              width: 430,
              height: 400,
              child: Container(
                width: 420,
                height: 382,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                  ),
                ),
                //
              ),
            ),
            Positioned(
              top: 400,
              child: Container(
                color: Colors.amber,
                width: 430,
                height: 411,
                child: Container(
                  width: 420,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150),
                    ),
                  ),
                ),
              ),
            ),
            const SalesReportScreen()
          ],
        ),
      ),
    );
  }
}

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context);
    final userid = state.loggedUser!.id;
    final username = state.loggedUser!.nomeloja;
    final usercnpj = state.loggedUser!.cnpj;
    return ChangeNotifierProvider(
      create: (context) {
        return SalesReportController(person: userid!);
      },
      child: Consumer<SalesReportController>(
        builder: (_, state, __) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.listsale.length,
            itemBuilder: (context, index) {
              final saleReport = state.listsale[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          trailing: PopupMenuButton<String>(
                            onSelected: (choice) async {
                              if (choice == 'Opção 1') {}
                            },
                            itemBuilder: (context) {
                              return <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Opção 1',
                                  child: Text('Deletar Usuario'),
                                ),
                              ];
                            },
                          ),
                          title: Text(
                            'Vendedor : $username ',
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text('Cnpj : $usercnpj '),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '   Comprador :'
                                      ' ${saleReport.customerName}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Valor da Venda :'
                                      ' ${saleReport.priceSold}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Ganho da loja:'
                                      ' ${saleReport.businessPercentage}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Ganho da rede :'
                                      ' ${saleReport.dealershipPercentage}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Caixa de segurança:'
                                      ' ${saleReport.safetyPercentage}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
