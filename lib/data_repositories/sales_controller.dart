import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../entidades/autonomy_level.dart';
import '../entidades/sales.dart';
import '../entidades/vehicle.dart';
import 'database/db.dart';

/// responsible for managing the state of the SaleVehicle class
class SaleController extends ChangeNotifier {
  ///constructor with the necessary parameters
  SaleController({
    required this.userCnpj,
    required this.brand,
    required this.model,
    required this.nameUser,
    required this.person,
    required this.vehicle,
    required this.plate,
  }) {
    unawaited(loadData());
  }

  final _listSales = <Sale>[];

  /// get from the listsale
  List<Sale> get listsale => _listSales;

  ///database table sale controller
  final saleController = SaleTableController();

  /// object vehicle
  final Vehicle vehicle;

  ///id person
  final int person;

  /// name user
  final String nameUser;

  ///brand of vehicle
  final String brand;

  /// model of vehicle
  final String model;

  /// cnpj  of user current
  final String userCnpj;

  /// plate of vehicle
  final String plate;
  final _listAutomomydata = <AutonomyLevel>[];

  /// get from autonomy list
  List<AutonomyLevel> get listAutonomydata => _listAutomomydata;

  ///controller db from autonomy table
  final controllerAutonomy = AutonomyControler();

  ///vehicle sales form validator
  final formkey = GlobalKey<FormState>();
  final _customerCpf = TextEditingController();
  final _custumerName = TextEditingController();
  final _soldwhen = TextEditingController();
  final _priceSold = TextEditingController();

  /// get cpf
  TextEditingController get customerCpf => _customerCpf;

  ///get buyer name
  TextEditingController get custumerName => _custumerName;

  /// get date current
  TextEditingController get soldwhen => _soldwhen;

  ///get price
  TextEditingController get priceSold => _priceSold;

  /// get porcentage user current
  double? dealershipPercentag;

  /// get porcentage from store
  double? businessPercentag;

  /// get porcentage securyt box
  double? safetyPercentag;

  /// insert data the database
  Future<void> insert() async {
    if (autonomydataAnali) {
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
        nameUser: nameUser,
        brand: brand,
        model: model,
        userCnpj: userCnpj,
        plate: plate,
      );

      await saleController.insert(saleVehicle);

      _customerCpf.clear();
      _custumerName.clear();
      _priceSold.clear();
      _soldwhen.clear();
      await loadData();
      notifyListeners();
    }
  }

  /// verification autonomy
  bool autonomydataAnali = false;

  /// responsible for getting the autonomy level of the logged in
  ///  user chama no botao de vender
  Future<void> dataAutonomy(int idperson) async {
    final list = await controllerAutonomy.select(person);

    if (list.isNotEmpty) {
      dealershipPercentag = list[0].networkPercentage;
      businessPercentag = list[0].storePercentage;
      safetyPercentag = list[0].networkSecurity;
      autonomydataAnali = true;
    }
    notifyListeners();
  }

  /// reload  autonomy list
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

  /// delete user of data base
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
