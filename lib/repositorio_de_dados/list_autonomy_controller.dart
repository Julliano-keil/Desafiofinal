import 'package:flutter/material.dart';
import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';

import 'db.dart';

class ListAutonomyController extends ChangeNotifier {
  ListAutonomyController({required this.person}) {
    loadata();
  }

  final Person person;
  final controller = AutonomyControler();
  final formkey = GlobalKey<FormState>();
  final _listaAutonomy = <AutonomyLevel>[];
  List<AutonomyLevel> get listaAutonomy => _listaAutonomy;
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
        name: _controllerNameNivel.text,
        networkSecurity: double.parse(_controllerNetworkSecurity.text),
        storePercentage: double.parse(_controllerStorePercentage.text),
        networkPercentage: double.parse(_controllerNetworkPercentage.text),
        personID: person.id ?? 0);
    await controller.insert(autonomy);
    controllerNameNivel.clear();
    controllerNetworkPercentage.clear();
    controllerNetworkSecurity.clear();
    controllerStorePercentag.clear();
    loadata();
    notifyListeners();
  }

  Future<void> loadata() async {
    final list = await controller.select(person.id ?? 0);
    listaAutonomy.clear();
    listaAutonomy.addAll(list);
    notifyListeners();
    for (var element in list) {
      print(element);
    }
  }

  Future<void> delete(AutonomyLevel autonomy) async {
    try {
      await controller.delete(autonomy);
      await loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo delet $e');
    }
  }
}
