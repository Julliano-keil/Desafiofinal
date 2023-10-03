import 'dart:async';

import 'package:flutter/widgets.dart';

import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';
import '../entidades/sales.dart';
import '../entidades/vehicle.dart';
import 'db.dart';

class SaleController extends ChangeNotifier {
  SaleController({required this.person, required this.vehicle}) {
    unawaited(loadData());
  }

  final _listSales = <Sale>[];
  List<Sale> get listsale => _listSales;

  final saleController = SaleTableController();
  final Vehicle vehicle;
  final Person person;
  AutonomyLevel? autonomy;
  final formkey = GlobalKey<FormState>();
  final _customerCpf = TextEditingController();
  final _custumerName = TextEditingController();
  final _soldwhen = TextEditingController();
  final _priceSold = TextEditingController();
  final _dealershipPercentage = TextEditingController();
  final _bussinessPercetenge = TextEditingController();
  final _safetyPercentage = TextEditingController();
  final _vehicleId = TextEditingController();
  final _dealershipId = TextEditingController();
  final _userId = TextEditingController();

  TextEditingController get customerCpf => _customerCpf;
  TextEditingController get custumerName => _custumerName;
  TextEditingController get soldwhen => _soldwhen;
  TextEditingController get priceSold => _priceSold;
  TextEditingController get dealershipPercentage => _dealershipPercentage;
  TextEditingController get bussinessPercetenge => _bussinessPercetenge;
  TextEditingController get safetyPercentage => _safetyPercentage;
  TextEditingController get vehicleId => _vehicleId;
  TextEditingController get dealershipId => _dealershipId;
  TextEditingController get userId => _userId;

  Future<void> insert() async {
    try {
      final saleVehicle = Sale(
        customerCpf: _customerCpf.text,
        customerName: _custumerName.text,
        soldWhen: _soldwhen.text,
        priceSold: double.parse(_priceSold.text),
        dealershipPercentage: double.parse(_dealershipPercentage.text),
        businessPercentage: double.parse(_bussinessPercetenge.text),
        safetyPercentage: double.parse(_safetyPercentage.text),
        vehicleId: vehicle.id ?? 0,
        dealershipId: autonomy!.id ?? 0,
        userId: person.id ?? 0,
      );

      await saleController.insert(saleVehicle);

      _bussinessPercetenge.clear();
      _customerCpf.clear();
      _custumerName.clear();
      _dealershipPercentage.clear();
      _priceSold.clear();
      _safetyPercentage.clear();
      _soldwhen.clear();
      await loadData();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no insert sale $e');
    }
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
