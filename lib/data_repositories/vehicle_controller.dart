import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../entidades/vehicle.dart';
import 'database/db.dart';

import 'vehicle_http.dart';

/// manages the state of the VehicleRegister class
class VehicleController extends ChangeNotifier {
  ///responsible for collecting mandatory variables
  VehicleController({required this.person, required this.nameUser}) {
    init();
    unawaited(loadData());
    unawaited(selectVehiclePersonId());
  }

  String? _controllerImage;

  ///get peson id current
  final int person;

  /// get name user current
  final String nameUser;

  /// sale true vehicle off
  bool editing = false;
  final _listvehicle = <Vehicle>[];

  /// get vehicle list
  List<Vehicle> get listavehicle => _listvehicle;
  final _listvehicleReport = <Vehicle>[];

  ///get vehicle list by id
  List<Vehicle> get listavehicleReport => _listvehicleReport;

  ///controller the autonomy table of data base
  final vehicleController = VehicleControllerdb();

  ///object vehicle
  Vehicle? vehicle;

  /// valid vehicle form
  final formkey = GlobalKey<FormState>();
  final _constrollermodel = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllerYearManufacture = TextEditingController();
  final _controlleryearVehicle = TextEditingController();
  final _controllerPricePaidShop = TextEditingController();
  final _controllerPurchaseDate = TextEditingController();

  ///get value from the model entered by the user
  TextEditingController get constrollermodel => _constrollermodel;

  ///get value from the brand entered by the user
  TextEditingController get controllerbrand => _controllerbrand;

  ///get value from the date year manufacturing entered by the user
  TextEditingController get controllerYearManufacture =>
      _controllerYearManufacture;

  ///get value from the date vehicle entered by the user
  TextEditingController get controlleryearVehicle => _controlleryearVehicle;

  ///get value from the price entered by the user
  TextEditingController get controllerPricePaidShop => _controllerPricePaidShop;

  ///get value from the date sale entered by the user
  TextEditingController get controllerPurchaseDate => _controllerPurchaseDate;

  ///get value from the image entered by the user
  String? get controllerImage => _controllerImage;

  ///inserts the vehicle object into the database
  Future<void> insert() async {
    final vehicle = Vehicle(
        idperson: person,
        model: _constrollermodel.text,
        brand: _controllerbrand.text,
        yearManufacture: _controllerYearManufacture.text.toUpperCase(),
        yearVehicle: _controlleryearVehicle.text.toUpperCase(),
        image: _controllerImage,
        pricePaidShop: double.parse(_controllerPricePaidShop.text),
        purchaseDate: _controllerPurchaseDate.text,
        nameUser: nameUser);
    await vehicleController.insert(vehicle);
    await loadData();
    clearcontroller();
    _controllerImage = null;
  }

  ///
  final brandFieldFocusNode = FocusNode();

  ///brend list json
  final allBrands = <String>[];

  ///models list json
  final allModels = <String>[];

  ///start brand
  void init() async {
    editing = false;
    final result = await getBrandNames();
    allBrands.addAll(result ?? []);
    showModels();
    editing = true;
  }

  ///method clear controller
  void clearcontroller() {
    constrollermodel.clear();
    controllerbrand.clear();
    controllerPricePaidShop.clear();
    controllerPurchaseDate.clear();
    controllerYearManufacture.clear();
    controllerPurchaseDate.clear();
    notifyListeners();
  }

  ///select vehicle list by id
  Future<void> selectVehiclePersonId() async {
    final list = await vehicleController.select(person);

    listavehicleReport.clear();
    listavehicleReport.addAll(list);
    notifyListeners();
  }

  ///select  all list
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

  /// show model jspn
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

  ///show brand json
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

  ///show model json
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

  ///get image of user's gallery
  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllerImage = image.path;
    }
    notifyListeners();
  }

////get image of user's camera
  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerImage = image.path;
      notifyListeners();
    }
  }
}

///manages the state of the category screen class
class CatergoryListController extends ChangeNotifier {
  ///responsible for collecting mandatory variables
  CatergoryListController({required this.person}) {
    unawaited(loadData());
  }

  ///controller the vehicle table of data base
  final vehicleCategory = VehicleControllerdb();

  ///get current user id
  final int person;
  final _listCategory = <Vehicle>[];

  ///get category list
  List<Vehicle> get listCategory => _listCategory;

  ///reload list / select all // select by id
  Future<void> loadData() async {
    try {
      final list = person == 1
          ? await vehicleCategory.selectlist()
          : await vehicleCategory.select(person);

      listCategory
        ..clear()
        ..addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no load data sale $e');
    }
  }

  ///delete user by id
  Future<void> delete(Vehicle vehicle) async {
    try {
      await vehicleCategory.delete(vehicle);
      await loadData();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no delete sale $e');
    }
  }
}
