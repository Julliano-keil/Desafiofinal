import 'dart:async';

import 'package:flutter/material.dart';
import '../entidades/person.dart';
import 'database/db.dart';

//////  manages the state of the singup class
class SignUpController extends ChangeNotifier {
  ///responsible for collecting mandatory variables
  SignUpController() {
    unawaited(loadata());
  }

  late Person _personcurrent;

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
        password: _controllerSenha.text);

    await controller.insert(people);
    controllerCnpj.clear();
    controllerName.clear();
    controllerSenha.clear();
    await loadata();
    notifyListeners();
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

    _personcurrent = Person(
        id: person.id,
        cnpj: person.cnpj,
        storeName: person.storeName,
        password: person.password);
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
          password: _controllerSenha.text);

      await controller.update(person);
      controllerCnpj.clear();
      controllerName.clear();
      controllerSenha.clear();
      await loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo insert $e');
    }
  }
}
