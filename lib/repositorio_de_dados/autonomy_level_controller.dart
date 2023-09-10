import 'package:flutter/material.dart';
import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';

import 'db.dart';

class AutonomilevelControler extends ChangeNotifier {
  AutonomilevelControler({required this.person}) {
    loadata();
  }

  final Person person;
  final controller = AutonomyControler();
  final formkey = GlobalKey<FormState>();
  final _listaAutonomy = <AutonomyLevel>[];
  List<AutonomyLevel> get listaAutonomy => _listaAutonomy;
  final _constrollerPersonID = TextEditingController();
  final _controllerNameNivel = TextEditingController();
  final _controllerNetworkSecurity = TextEditingController();
  final _controllerStorePercentage = TextEditingController();
  final _controllerNetworkPercentage = TextEditingController();

  TextEditingController get controllerNameNivel => _controllerNameNivel;
  TextEditingController get controllerNetworkSecurity =>
      _controllerNetworkSecurity;
  TextEditingController get controllerStorePercentag =>
      _controllerStorePercentage;
  TextEditingController get controllerNetworkPercentage =>
      _controllerNetworkPercentage;

  Future<void> insert() async {
    try {
      final autonomy = AutonomyLevel(
          name: _controllerNameNivel.text,
          networkSecurity: double.parse(_controllerNetworkSecurity.text),
          storePercentage: double.parse(_controllerStorePercentage.text),
          networkPercentage: double.parse(_controllerNetworkPercentage.text),
          personID: int.tryParse(_constrollerPersonID.text) ?? 0);
      debugPrint(' person ___________  =>$_constrollerPersonID');
      await controller.insert(autonomy);
      controllerNameNivel.clear();
      controllerNetworkPercentage.clear();
      controllerNetworkSecurity.clear();
      controllerStorePercentag.clear();
      loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro nometodo insert Erro=> $e');
    }
  }

  Future<void> loadata() async {
    final list = await controller.select(person.id ?? 0);
    listaAutonomy.clear();
    listaAutonomy.addAll(list);
    notifyListeners();
  }
}
