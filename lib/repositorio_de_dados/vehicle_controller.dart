import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../entidades/vehicle.dart';
import 'database/db.dart';
import 'images.dart';
import 'vehicle_http.dart';

class VehicleController extends ChangeNotifier {
  VehicleController({required this.person, required this.nameUser}) {
    init();
    unawaited(loadData());
    unawaited(selectVehiclePersonId());
  }

  String? _controllerImage;
  final int person;
  final String nameUser;
  bool editing = false;
  final _listvehicle = <Vehicle>[];
  List<Vehicle> get listavehicle => _listvehicle;
  final _listvehicleReport = <Vehicle>[];
  List<Vehicle> get listavehicleReport => _listvehicleReport;

  final vehicleController = VehicleControllerdb();
  Vehicle? vehicle;
  final formkey = GlobalKey<FormState>();
  final _constrollermodel = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllerYearManufacture = TextEditingController();
  final _controlleryearVehicle = TextEditingController();
  final _controllerPricePaidShop = TextEditingController();
  final _controllerPurchaseDate = TextEditingController();

  TextEditingController get constrollermodel => _constrollermodel;
  TextEditingController get controllerbrand => _controllerbrand;
  TextEditingController get controllerYearManufacture =>
      _controllerYearManufacture;
  TextEditingController get controlleryearVehicle => _controlleryearVehicle;
  TextEditingController get controllerPricePaidShop => _controllerPricePaidShop;
  TextEditingController get controllerPurchaseDate => _controllerPurchaseDate;
  String? get controllerImage => _controllerImage;

  Future<void> insert() async {
    final vehicle = Vehicle(
        idperson: person,
        model: _constrollermodel.text,
        brand: _controllerbrand.text,
        yearManufacture: _controllerYearManufacture.text,
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

  final brandFieldFocusNode = FocusNode();

  final allBrands = <String>[];
  final allModels = <String>[];

  void init() async {
    editing = false;
    final result = await getBrandNames();
    allBrands.addAll(result ?? []);
    showModels();
    editing = true;
  }

  void clearcontroller() {
    constrollermodel.clear();
    controllerbrand.clear();
    controllerPricePaidShop.clear();
    controllerPurchaseDate.clear();
    controllerYearManufacture.clear();
    controllerPurchaseDate.clear();
    notifyListeners();
  }

  Future<void> selectVehiclePersonId() async {
    final list = await vehicleController.select(person);

    listavehicleReport.clear();
    listavehicleReport.addAll(list);
    notifyListeners();
  }

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

  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllerImage = image.path;
    }
    notifyListeners();
  }

  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerImage = image.path;
      notifyListeners();
    }
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  void setPickedDate(String date) {
    _controllerPurchaseDate.text = date;
    notifyListeners();
  }
}

class CatergoryListController extends ChangeNotifier {
  CatergoryListController({required this.person}) {
    unawaited(loadData());
    // unawaited(loadDataFull());
  }
  final vehicleCategory = VehicleControllerdb();
  final int person;
  final _listCategory = <Vehicle>[];

  List<Vehicle> get listCategory => _listCategory;

  final _listCategoryFull = <Vehicle>[];

  List<Vehicle> get listCategoryFull => _listCategoryFull;

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
}
