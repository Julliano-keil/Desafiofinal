import 'package:flutter/widgets.dart';
import '../entidades/vehicle.dart';
import 'db.dart';
import 'vehicle_http.dart';

class VehicleController extends ChangeNotifier {
  VehicleController({
    this.vehicle,
  }) {
    init(vehicle);
  }
  final controller = VehicleControllerdb();
  final _listaVehicle = <Vehicle>[];
  bool editing = false;
  Vehicle? vehicle;
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
        yearManufacture: _controllerYearManufacture.text,
        yearVehicle: _controlleryearVehicle.text,
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

  Future<void> loadData(int vehicleId) async {
    final result = await controller.select(vehicleId);
    if (result.length == 1) {
      vehicle = result.first;
      notifyListeners();
    } else {
      throw Exception('The select method returned more than one vehicle');
    }
  }

  final brandFieldFocusNode = FocusNode();

  final allBrands = <String>[];
  final allModels = <String>[];

  void init(Vehicle? vehicle) async {
    editing = false;

    if (vehicle == null) {
      final result = await getBrandNames();

      allBrands.addAll(result ?? []);

      showModels();
    } else {
      editing = true;
    }
  }

  void showModels() async {
    brandFieldFocusNode.addListener(
      () async {
        if (brandFieldFocusNode.hasFocus) {
          final result = await getModelsByBrand(controllerbrand.text);
          allModels.clear();
          allModels.addAll(result!);
          notifyListeners();
        }
      },
    );
  }

  Future<List<String>?> getBrandNames() async {
    final brandsList = await getCarBrands();

    final brandNames = <String>[];

    if (brandsList != null) {
      for (final item in brandsList) {
        brandNames.add(item.name!);
      }
    }
    return brandNames;
  }

  Future<List<String>?> getModelsByBrand(String brand) async {
    final modelsList = await getCarModel(brand);

    final modelNames = <String>[];

    if (modelsList != null) {
      for (final item in modelsList) {
        modelNames.add(item.name!);
      }
    }
    return modelNames;
  }
}
