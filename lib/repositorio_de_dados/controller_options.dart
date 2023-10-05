import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../entidades/vehicle.dart';
import 'database/db.dart';
import 'images.dart';

class Vehiclelist with ChangeNotifier {
  Vehiclelist() {
    unawaited(loadData());
  }

  bool loading = true;
  final _listvehicle = <Vehicle>[];
  List<Vehicle> get listavehicle => _listvehicle;

  final vehicleController = VehicleControllerdb();
  Vehicle? vehicle;

  Future<void> loadData() async {
    try {
      final list = await vehicleController.selectlist();
      listavehicle.clear();
      listavehicle.addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no metodo loaddata $e');
    }
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  void deleteVehicle(Vehicle vehicle) async {
    await vehicleController.delete(vehicle);

    notifyListeners();
  }
}
