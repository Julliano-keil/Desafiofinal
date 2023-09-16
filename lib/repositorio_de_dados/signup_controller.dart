import 'package:flutter/material.dart';
import '../entidades/person.dart';
import 'db.dart';

class SignUpController extends ChangeNotifier {
  SignUpController() {
    loadata();
  }
  String nameuser = '';
  Person? _personcurrent;

  final controller = PessoaControler();
  final _listaPeople = <Person>[];
  final formkey = GlobalKey<FormState>();
  List<Person> get listaPeople => _listaPeople;
  final formKey = GlobalKey<FormState>();
  final _controllerId = TextEditingController();
  final _controllerCnpj = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerNivel = TextEditingController();
  final _controllerSenha = TextEditingController();
  final _controlerNivel = TextEditingController();

  TextEditingController get controllerCnpj => _controllerCnpj;
  TextEditingController get controllerName => _controllerName;
  TextEditingController get controllerNivel => _controllerNivel;
  TextEditingController get controllerSenha => _controllerSenha;
  TextEditingController get controllerid => _controllerId;
  TextEditingController get controlerNivel => _controlerNivel;

  Future<void> delete(Person person) async {
    try {
      await controller.delete(person);
      await loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo delet $e');
    }
  }

  Future<void> insert() async {
    try {
      final people = Person(
          cnpj: int.parse(_controllerCnpj.text),
          nomeloja: _controllerName.text,
          senha: _controllerSenha.text);

      await controller.insert(people);
      controllerCnpj.clear();
      controllerName.clear();
      controllerNivel.clear();
      controllerSenha.clear();
      loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo insert $e');
    }
  }

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

  void updatePerson(Person person) {
    _controllerCnpj.text = person.cnpj.toString();
    _controllerName.text = person.nomeloja ?? '';
    _controllerSenha.text = person.senha ?? '';

    _personcurrent = Person(
        id: person.id,
        cnpj: person.cnpj,
        nomeloja: person.nomeloja,
        senha: person.senha);
    loadata();
    notifyListeners();
  }

  Future<void> update() async {
    try {
      final person = Person(
          id: _personcurrent?.id,
          cnpj: int.parse(_controllerCnpj.text),
          nomeloja: _controllerName.text,
          senha: _controllerSenha.text);

      await controller.update(person);
      controllerCnpj.clear();
      controllerName.clear();
      controllerNivel.clear();
      controllerSenha.clear();
      loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo insert $e');
    }
  }
}
