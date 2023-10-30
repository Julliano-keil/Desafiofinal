import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../entidades/person.dart';
import 'database/db.dart';

///  manages the state of the Profileuser class
class ProfileController extends ChangeNotifier {
  ///responsible for collecting mandatory variables
  ProfileController({required this.personid}) {
    unawaited(loadData());
    unawaited(dataAutonomy(personid));
  }
  final _listProfile = <Person>[];

  ///get the profile list
  List<Person> get listProfile => _listProfile;
  String? _controllerImage;

  /// get user id current
  final int personid;

  Person? _profileCurrent;

  /// object with information user current
  Person? userpro;

  ///image current
  String? image;

  /// user current
  int? userid;

  String? cnpj;

  String? passWord;

  String? storeName;

  /// id profile current
  int? id;

  ///shows autonomy of user current
  double? dealershipPercentag;

  ///
  double? businessPercentag;

  ///
  double? safetyPercentag;

  ///
  String? nameautonomy;

  ///controller the autonomy table of data base
  final controllerAutonomy = AutonomyControler();

  ///controller the profile table of data base
  final controllerProfile = PessoaControler();

  /// get image typed user
  String? get controllerImage => _controllerImage;

  ///reload profile list and fill userpro with user information
  Future<void> loadData() async {
    final list = await controllerProfile.selectUser(personid);

    if (list.isNotEmpty) {
      id = list[0].id;
      cnpj = list[0].cnpj;
      storeName = list[0].storeName;
      passWord = list[0].password;
      image = list[0].imageuser;
      print(image);
      userpro = Person(
          id: id,
          cnpj: cnpj,
          storeName: storeName,
          password: passWord,
          imageuser: image);

      listProfile.clear();
      listProfile.addAll(list);
    }
    notifyListeners();
  }

  /// reload current user autonomy information
  Future<void> dataAutonomy(int idperson) async {
    final list = await controllerAutonomy.select(idperson);

    if (list.isNotEmpty) {
      nameautonomy = list[0].name;
      dealershipPercentag = list[0].networkPercentage;
      businessPercentag = list[0].storePercentage;
      safetyPercentag = list[0].networkSecurity;
    }
    notifyListeners();
  }

  ///
  void updatePerson(Person person) async {
    _controllerImage = person.imageuser ?? '';

    _profileCurrent = Person(
      id: person.id,
      cnpj: person.cnpj,
      storeName: person.storeName,
      password: person.password,
      imageuser: person.imageuser,
    );
    await loadData();
    notifyListeners();
  }

  ///update user by id
  Future<void> update() async {
    try {
      final person = Person(
        id: _profileCurrent?.id,
        cnpj: cnpj,
        password: passWord,
        storeName: storeName,
        imageuser: _controllerImage,
      );

      await controllerProfile.update(person);

      _controllerImage == null;
      await loadData();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo insert $e');
    }
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

  ///get image of user's camera
  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerImage = image.path;
      notifyListeners();
    }
  }
}
