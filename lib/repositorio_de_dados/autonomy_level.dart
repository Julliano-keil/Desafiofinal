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
  final _listaAutonomy = <AutonomyLevel>[];
  List<AutonomyLevel> get listaAutonomy => _listaAutonomy;
  final _controllerPersonid = TextEditingController();
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
    final autonomy = AutonomyLevel(
        personID: int.parse(_controllerPersonid.text),
        name: _controllerNameNivel.text,
        networkSecurity: double.parse(_controllerNetworkSecurity.text),
        storePercentage: double.parse(_controllerStorePercentage.text),
        networkPercentage: double.parse(_controllerNetworkPercentage.text));

    await controller.insert(autonomy);
    controllerNameNivel.clear();
    controllerNetworkPercentage.clear();
    controllerNetworkSecurity.clear();
    controllerStorePercentag.clear();
    notifyListeners();
  }

  Future<void> loadata() async {
    final list = await controller.select(person.id);
    listaAutonomy.clear();
    listaAutonomy.addAll(list);
    notifyListeners();
  }
}
