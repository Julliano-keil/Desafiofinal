import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../entidades/vehicle.dart';
import 'database/db.dart';

/// A class for managing a list of vehicles.
class VehicleList with ChangeNotifier {
  /// Constructor for initializing the VehicleList.
  VehicleList() {
    unawaited(loadData());
  }

  /// Indicates whether the data is currently being loaded.
  bool loading = true;
  final _listVehicle = <Vehicle>[];

  /// A list of vehicles.
  List<Vehicle> get listaVehicle => _listVehicle;

  ///
  final vehicleController = VehicleControllerdb();

  ///
  Vehicle? vehicle;

  /// Loads data for the list of vehicles.
  Future<void> loadData() async {
    try {
      final list = await vehicleController.selectlist();
      listaVehicle.clear();
      listaVehicle.addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Error in the loadData method: $e');
    }
  }

  /// Deletes a vehicle from the list.
  void deleteVehicle(Vehicle vehicle) async {
    await vehicleController.delete(vehicle);
    notifyListeners();
  }
}
