import 'dart:async';

import 'package:flutter/material.dart';

import '../entidades/sales.dart';
import 'database/db.dart';

/// manages the state of the salesReport class
class SalesReportController extends ChangeNotifier {
  ///responsible for collecting mandatory variables
  SalesReportController({required this.person}) {
    unawaited(loadData());
    unawaited(selectLatest());
  }

  ///controller the sale table of data base
  final saleController = SaleTableController();

  ///get id user current
  final int person;

  final _listSales = <Sale>[];

  ///get sale list
  List<Sale> get listsale => _listSales;
  final _listSalesLatest = <Sale>[];

  ///get sale listlatest
  List<Sale> get listsaleLatest => _listSalesLatest;

  ///reload sale list
  Future<void> loadData() async {
    try {
      final list = person == 1
          ? await saleController.select()
          : await saleController.selectlist(person);

      listsale
        ..clear()
        ..addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no load data sale $e');
    }
  }

  /// get the latest sale
  Future<void> selectLatest() async {
    try {
      final list = person == 1
          ? await saleController.select()
          : await saleController.selectlatest(person);

      listsaleLatest
        ..clear()
        ..addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no load data sale $e');
    }
  }

  ///delete sale list with id corresponding
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
