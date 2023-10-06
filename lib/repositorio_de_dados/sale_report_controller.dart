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
      final list = await saleController.selectlist(person);

      listsale
        ..clear()
        ..addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no load data sale $e');
    }
  }
}
