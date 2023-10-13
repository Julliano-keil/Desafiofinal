import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';

import '../casos_de_usos/settings_code.dart';
import '../repositorio_de_dados/person_controler.dart';
import '../repositorio_de_dados/sale_report_controller.dart';

///class responsible for listing the sales report and importing it via PDF
class SalesReport extends StatelessWidget {
  ///constructor class
  SalesReport({super.key});

  final Settingscode color = Settingscode();

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settingscode>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async => Get.back(),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        backgroundColor: Colors.black,
        title: const Text('Relatorios de vendas'),
        centerTitle: true,
      ),
      body: AnimatedContainer(
        width: double.infinity,
        height: double.infinity,
        color: settings.ligthMode ? Colors.amber : Colors.white,
        duration: const Duration(seconds: 2),
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              width: 430,
              height: 400,
              child: Container(
                width: 420,
                height: 382,
                decoration: BoxDecoration(
                  color: settings.ligthMode ? Colors.amber : Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(200),
                  ),
                ),
                //
              ),
            ),
            Positioned(
              top: 400,
              child: Container(
                color: settings.ligthMode ? Colors.amber : Colors.white,
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
            const _SalesReportScreen()
          ],
        ),
      ),
    );
  }
}

class _SalesReportScreen extends StatelessWidget {
  const _SalesReportScreen();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context, listen: false);
    final userid = state.loggedUser!.id;

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
                              if (choice == 'Opção 1') {
                                await state.delete(saleReport);
                              }
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
                            'Vendedor : ${saleReport.nameUser} ',
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text('Cnpj : ${saleReport.userCnpj} '),
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
                                  const Center(
                                    child: Text('Comprador',
                                        style: TextStyle(fontSize: 19)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Nome :'
                                      ' ${saleReport.customerName}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Cpf :'
                                      ' ${saleReport.customerCpf}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                    child: Text('Logistica',
                                        style: TextStyle(fontSize: 19)),
                                  ),
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
                                  Text(
                                      '   data:'
                                      ' ${saleReport.soldWhen}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text('Veiculo vendido',
                                        style: TextStyle(fontSize: 19)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Marca:'
                                      ' ${saleReport.brand}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '   Modelo:'
                                      ' ${saleReport.model}',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      saleReport.plate.isNotEmpty
                                          ? '   Placa:'
                                              ' ${saleReport.plate}'
                                          : ' placa nao registrada',
                                      style: const TextStyle(fontSize: 19)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              _gerarPDF(
                                  saleReport.customerName,
                                  saleReport.customerCpf,
                                  saleReport.soldWhen,
                                  saleReport.brand,
                                  saleReport.plate,
                                  saleReport.priceSold.toString());
                            },
                            icon: const Icon(Icons.picture_as_pdf_outlined),
                            label: const Text('PDF'))
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

void _gerarPDF(String nome, String cpf, String data, String carro, String placa,
    String preco) async {
  final pdf = pw.Document(deflate: zlib.encode);

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Nome: $nome',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('CPF: $cpf',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Data: $data',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Carro: $carro',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Placa: $placa',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Preço: $preco',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ],
        );
      },
    ),
  );

  final docDir = (await getApplicationDocumentsDirectory()).path;

  final path = '$docDir/seu_arquivo.pdf';

  final file = File(path);
  file.writeAsBytesSync(await pdf.save());

  await ShareExtend.share(path, 'pdf', sharePanelTitle: 'enviar pdf');
}
