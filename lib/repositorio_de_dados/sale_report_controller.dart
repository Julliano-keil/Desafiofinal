import 'dart:async';

import 'package:flutter/material.dart';

import '../entidades/sales.dart';
import 'database/db.dart';

class SalesReportController extends ChangeNotifier {
  SalesReportController({required this.person}) {
    unawaited(loadData());
  }
  final saleController = SaleTableController();
  final int person;
  final _listSales = <Sale>[];

  List<Sale> get listsale => _listSales;

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
