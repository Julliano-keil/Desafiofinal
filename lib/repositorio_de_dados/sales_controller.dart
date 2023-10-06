import 'dart:async';

import 'package:flutter/widgets.dart';

import '../casos_de_usos/autonomy_data.dart';
import '../entidades/autonomy_level.dart';

import '../entidades/sales.dart';
import '../entidades/vehicle.dart';
import 'database/db.dart';

class SaleController extends ChangeNotifier {
  SaleController({required this.person, required this.vehicle}) {
    unawaited(loadData());
  }

  final _listSales = <Sale>[];
  List<Sale> get listsale => _listSales;

  final saleController = SaleTableController();
  final Vehicle vehicle;
  final int person;
  final _listAutomomydata = <AutonomyLevel>[];
  List<AutonomyLevel> get listAutonomydata => _listAutomomydata;
  final autonomyProvider = AutonomyProvider([]);
  final controllerAutonomy = AutonomyControler();

  final formkey = GlobalKey<FormState>();
  final _customerCpf = TextEditingController();
  final _custumerName = TextEditingController();
  final _soldwhen = TextEditingController();
  final _priceSold = TextEditingController();
  // final _dealershipPercentage = TextEditingController();
  // final _bussinessPercetenge = TextEditingController();
//  final _safetyPercentage = TextEditingController();
  final _vehicleId = TextEditingController();
  final _userId = TextEditingController();

  TextEditingController get customerCpf => _customerCpf;
  TextEditingController get custumerName => _custumerName;
  TextEditingController get soldwhen => _soldwhen;
  TextEditingController get priceSold => _priceSold;
  // TextEditingController get dealershipPercentage => _dealershipPercentage;
  //TextEditingController get bussinessPercetenge => _bussinessPercetenge;
  // TextEditingController get safetyPercentage => _safetyPercentage;
  TextEditingController get vehicleId => _vehicleId;
  TextEditingController get userId => _userId;

  double? dealershipPercentag;
  double? businessPercentag;
  double? safetyPercentag;
  Future<void> insert() async {
    try {
      final saleVehicle = Sale(
        customerCpf: _customerCpf.text,
        customerName: _custumerName.text,
        soldWhen: _soldwhen.text,
        priceSold: double.parse(_priceSold.text),
        dealershipPercentage:
            (dealershipPercentag! / 100) * double.parse(_priceSold.text),
        businessPercentage:
            (businessPercentag! / 100) * double.parse(_priceSold.text),
        safetyPercentage:
            (safetyPercentag! / 100) * double.parse(_priceSold.text),
        vehicleId: vehicle.id ?? 0,
        userId: person,
      );

      await saleController.insert(saleVehicle);

      _customerCpf.clear();
      _custumerName.clear();
      _priceSold.clear();
      _soldwhen.clear();
      await loadData();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no insert sale $e');
    }
  }

  Future<void> dataAutonomy(int idperson) async {
    final list = await controllerAutonomy.select(idperson);

    if (list.isNotEmpty) {
      dealershipPercentag = list[0].networkPercentage;
      businessPercentag = list[0].storePercentage;
      safetyPercentag = list[0].networkSecurity;
    }
    notifyListeners();
  }

  Future<void> loadData() async {
    try {
      final list = await saleController.select();

      listsale
        ..clear()
        ..addAll(list);
    } on Exception catch (e) {
      debugPrint('erro no load data sale $e');
    }
  }

  Future<void> delete(Sale sale) async {
    try {
      await saleController.delete(sale);
      await loadData();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no delete sale $e');
    }
  }
}
