import 'dart:async';
import 'package:flutter/material.dart';

import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';
import 'database/db.dart';

/// Controller class for managing Autonomy Levels.
class AutonomilevelControler extends ChangeNotifier {
  /// Creates a new AutonomilevelController for the specified person.
  AutonomilevelControler({required this.person}) {
    unawaited(loadData());
  }

  /// The associated person for whom autonomy levels are managed.
  Person person;

  /// The currently selected autonomy level.
  AutonomyLevel? _autonomyCurrent;

  /// Controller for managing autonomy levels.
  final controller = AutonomyControler();

  /// GlobalKey for the form widget.
  final formkey = GlobalKey<FormState>();

  /// List of autonomy levels.
  final List<AutonomyLevel> _listaAutonomy = [];

  /// Getter for the list of autonomy levels.
  List<AutonomyLevel> get listaAutonomy => _listaAutonomy;

  /// List of complete autonomy levels.
  final List<AutonomyLevel> _listaAutonomyComplete = [];

  /// Getter for the list of complete autonomy levels.
  List<AutonomyLevel> get listComplete => _listaAutonomyComplete;

  /// Text controller for autonomy level name.
  final _controllerNameNivel = TextEditingController();

  /// Getter for the autonomy level name text controller.
  TextEditingController get controllerNameNivel => _controllerNameNivel;

  /// Text controller for network security value.
  final _controllerNetworkSecurity = TextEditingController();

  /// Getter for the network security text controller.
  TextEditingController get controllerNetworkSecurity =>
      _controllerNetworkSecurity;

  /// Text controller for store percentage value.
  final _controllerStorePercentage = TextEditingController();

  /// Getter for the store percentage text controller.
  TextEditingController get controllerStorePercentage =>
      _controllerStorePercentage;

  /// Text controller for network percentage value.
  final _controllerNetworkPercentage = TextEditingController();

  /// Getter for the network percentage text controller.
  TextEditingController get controllerNetworkPercentage =>
      _controllerNetworkPercentage;

  /// Inserts a new autonomy level for the associated person.
  Future<void> insert() async {
    try {
      if (listaAutonomy.isNotEmpty) {
        debugPrint('Already registered!');
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
        controllerStorePercentage.clear();

        unawaited(loadData());

        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint('Error in the insert method: $e');
    }
  }

  /// Loads autonomy level data for the associated person.
  Future<void> loadData() async {
    final list = await controller.select(person.id ?? 0);

    listaAutonomy.clear();
    listaAutonomy.addAll(list);

    notifyListeners();
  }

  /// Updates the current autonomy level with the provided data.
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
    unawaited(loadData());
    notifyListeners();
  }

  /// Updates the autonomy level with the provided data.
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
      unawaited(loadData());
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Error in the update method: $e');
    }
  }

  /// Clears the text controllers and loads autonomy level data.
  void cleanController() {
    controllerNameNivel.clear();
    controllerNetworkPercentage.clear();
    controllerNetworkSecurity.clear();
    controllerStorePercentage.clear();
    unawaited(loadData());
    notifyListeners();
  }

  /// Deletes the provided autonomy level.
  Future<void> delete(AutonomyLevel autonomy) async {
    try {
      await controller.delete(autonomy);
      await loadData();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Error in the delete method: $e');
    }
  }
}
