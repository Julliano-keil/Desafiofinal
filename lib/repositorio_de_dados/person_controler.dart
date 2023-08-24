import 'package:flutter/material.dart';
import 'package:jscar/entidades/person_login.dart';
import 'package:jscar/repositorio_de_dados/db.dart';

class PersonControler extends ChangeNotifier {
  PersonControler() {
    loadata();
  }
  final constroller = PessoaControler();
  final _listaPeople = <Person>[];
  List<Person> get listaPeople => _listaPeople;
  final _controllerId = TextEditingController();
  final _controllerCnpj = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerNivel = TextEditingController();
  final _controllerSenha = TextEditingController();

  TextEditingController get controllerCnpj => _controllerCnpj;
  TextEditingController get controllerName => _controllerName;
  TextEditingController get controllerNivel => _controllerNivel;
  TextEditingController get controllerSenha => _controllerSenha;
  TextEditingController get controllerid => _controllerId;

  Future<void> insert() async {
    final people = Person(
        cnpj: int.parse(_controllerCnpj.text),
        nomeloja: _controllerName.text,
        senha: _controllerSenha.text);

    await constroller.insert(people);
    controllerCnpj.clear();
    controllerName.clear();
    controllerNivel.clear();
    controllerSenha.clear();
  }

  Future<void> loadata() async {
    final list = await constroller.select();
    listaPeople.clear();
    listaPeople.addAll(list);
    notifyListeners();
  }
}
