import 'package:flutter/widgets.dart';

import '../entidades/vehicle.dart';
import 'db.dart';

class VehicleController extends ChangeNotifier {
  final controller = VehicleControllerdb();
  final _listaVehicle = <Vehicle>[];
  List<Vehicle> get listvehicle => _listaVehicle;
  final formkey = GlobalKey<FormState>();
  final _constrollermodel = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllerYearManufacture = TextEditingController();
  final _controlleryearVehicle = TextEditingController();
  final _controllerImage = TextEditingController();
  final _controllerPricePaidShop = TextEditingController();
  final _controllerPurchaseDate = TextEditingController();

  TextEditingController get constrollermodel => _constrollermodel;
  TextEditingController get controllerbrand => _controllerbrand;
  TextEditingController get controllerYearManufacture =>
      _controllerYearManufacture;
  TextEditingController get controlleryearVehicle => _controlleryearVehicle;
  TextEditingController get controllerImage => _controllerImage;
  TextEditingController get controllerPricePaidShop => _controllerPricePaidShop;
  TextEditingController get controllerPurchaseDate => _controllerPurchaseDate;

  Future<void> insert() async {
    final vehicle = Vehicle(
        model: _constrollermodel.text,
        brand: _controllerbrand.text,
        yearManufacture: int.parse(_controllerYearManufacture.text),
        yearVehicle: int.parse(_controlleryearVehicle.text),
        image: _controllerImage.text,
        pricePaidShop: double.parse(_controllerPricePaidShop.text),
        purchaseDate: _controllerPurchaseDate.text);
    await controller.insert(vehicle);
    constrollermodel.clear();
    controllerImage.clear();
    controllerbrand.clear();
    controllerPricePaidShop.clear();
    controllerPurchaseDate.clear();
    controllerYearManufacture.clear();
    controllerPurchaseDate.clear();
  }
}
