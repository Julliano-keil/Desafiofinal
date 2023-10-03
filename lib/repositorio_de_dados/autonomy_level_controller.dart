import 'dart:async';

import 'package:flutter/material.dart';

import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';

import 'db.dart';

class AutonomilevelControler extends ChangeNotifier {
  AutonomilevelControler({required this.person}) {
    unawaited(loadata());
  }

  Person person;
  AutonomyLevel? _autonomyCurrent;
  final controller = AutonomyControler();
  final formkey = GlobalKey<FormState>();
  final _listaAutonomy = <AutonomyLevel>[];
  List<AutonomyLevel> get listaAutonomy => _listaAutonomy;
  final _listaAutonomyComplete = <AutonomyLevel>[];
  List<AutonomyLevel> get listComplete => _listaAutonomyComplete;

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
      if (listaAutonomy.isNotEmpty) {
        debugPrint('ja cadastrado! ');
      } else if (person.id != null) {
        final autonomy = AutonomyLevel(
          name: _controllerNameNivel.text,
          networkSecurity: double.parse(_controllerNetworkSecurity.text),
          storePercentage: double.parse(_controllerStorePercentage.text),
          networkPercentage: double.parse(_controllerNetworkPercentage.text),
          personID: person.id ?? 0,
        );

        await controller.insert(autonomy);

        controllerNameNivel.clear();
        controllerNetworkPercentage.clear();
        controllerNetworkSecurity.clear();
        controllerStorePercentag.clear();

        unawaited(loadata());

        notifyListeners();
      }
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

  void updatePerson(AutonomyLevel autonomy) {
    _controllerNameNivel.text = autonomy.name;
    _controllerNetworkPercentage.text = autonomy.networkPercentage.toString();
    _controllerNetworkSecurity.text = autonomy.networkSecurity.toString();
    _controllerStorePercentage.text = autonomy.storePercentage.toString();

    _autonomyCurrent = AutonomyLevel(
        id: autonomy.id,
        name: autonomy.name,
        networkSecurity: autonomy.networkSecurity,
        storePercentage: autonomy.storePercentage,
        networkPercentage: autonomy.storePercentage,
        personID: person.id ?? 0);
    unawaited(loadata());
    notifyListeners();
  }

  Future<void> update() async {
    try {
      final autonomy = AutonomyLevel(
          id: _autonomyCurrent?.id,
          name: _controllerNameNivel.text,
          networkSecurity: double.parse(_controllerNetworkSecurity.text),
          storePercentage: double.parse(_controllerStorePercentage.text),
          networkPercentage: double.parse(_controllerNetworkPercentage.text),
          personID: person.id ?? 0);

      await controller.update(autonomy);
      cleanController();
      unawaited(loadata());
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo update $e');
    }
  }

  void cleanController() {
    controllerNameNivel.clear();
    controllerNetworkPercentage.clear();
    controllerNetworkSecurity.clear();
    controllerStorePercentag.clear();
    unawaited(loadata());
    notifyListeners();
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
