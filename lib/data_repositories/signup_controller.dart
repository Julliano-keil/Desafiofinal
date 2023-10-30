import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../entidades/person.dart';
import 'database/db.dart';

//////  manages the state of the singup class
class SignUpController extends ChangeNotifier {
  ///responsible for collecting mandatory variables
  SignUpController() {
    unawaited(loadata());
  }

  late Person _personcurrent;

  String? _controllerImage;

  ///controller the person table of data base
  final controller = PessoaControler();
  final _listaPeople = <Person>[];

  ///get perosn list
  List<Person> get listaPeople => _listaPeople;

  ///valid singup form
  final formKey = GlobalKey<FormState>();
  final _controllerCnpj = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerSenha = TextEditingController();

  ///obter cnpj informado pelo usuário
  TextEditingController get controllerCnpj => _controllerCnpj;

  ///obter name informado pelo usuário
  TextEditingController get controllerName => _controllerName;

  ///obter password informado pelo usuário
  TextEditingController get controllerSenha => _controllerSenha;

  /// get image typed user
  String? get controllerImage => _controllerImage;

  /// delete user
  Future<void> delete(Person person) async {
    await controller.delete(person);
    await loadata();
    notifyListeners();
  }

  ///insert person / user table of data base
  Future<void> insert() async {
    final people = Person(
        cnpj: _controllerCnpj.text,
        storeName: _controllerName.text,
        password: _controllerSenha.text,
        imageuser: _controllerImage);

    await controller.insert(people);
    controllerCnpj.clear();
    controllerName.clear();
    controllerSenha.clear();
    await loadata();
    notifyListeners();
  }

  ///random password
  void password() {
    final random = Random();

    ///random characters
    const chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
    const stringLength = 5;

    var randomString = '';

    for (var i = 0; i < stringLength; i++) {
      final randomIndex = random.nextInt(chars.length);
      randomString += chars[randomIndex];
      _controllerSenha.text = randomString.toUpperCase();
    }
  }

  ///reload person list
  Future<void> loadata() async {
    try {
      final list = await controller.select();
      listaPeople.clear();
      listaPeople.addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no metodo loaddata $e');
    }
  }

  /// populace user current
  void updatePerson(Person person) async {
    _controllerCnpj.text = person.cnpj.toString();
    _controllerName.text = person.storeName ?? '';
    _controllerSenha.text = person.password ?? '';
    _controllerImage = person.imageuser;

    _personcurrent = Person(
      id: person.id,
      cnpj: person.cnpj,
      storeName: person.storeName,
      password: person.password,
      imageuser: person.imageuser,
    );
    await loadata();
    notifyListeners();
  }

  ///update user by id
  Future<void> update() async {
    try {
      final person = Person(
        id: _personcurrent.id,
        cnpj: _controllerCnpj.text,
        storeName: _controllerName.text,
        password: _controllerSenha.text,
        imageuser: _controllerImage,
      );

      await controller.update(person);
      controllerCnpj.clear();
      controllerName.clear();
      controllerSenha.clear();
      _controllerImage == null;
      await loadata();
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
}
