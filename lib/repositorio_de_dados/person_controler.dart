import 'package:flutter/material.dart';
import '../entidades/person.dart';
import 'db.dart';

class PersonControler extends ChangeNotifier {
  PersonControler() {
    loadata();
  }
  String nameuser = '';

  final constroller = PessoaControler();
  final _listaPeople = <Person>[];
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

  Future<void> insert() async {
    try {
      final people = Person(
          id: int.parse(_controllerId.text),
          cnpj: int.parse(_controllerCnpj.text),
          nomeloja: _controllerName.text,
          senha: _controllerSenha.text);

      await constroller.insert(people);
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
      final list = await constroller.select();
      listaPeople.clear();
      listaPeople.addAll(list);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('erro no metodo loaddata $e');
    }
  }

  Future<dynamic> getUserByUsername(String username) async {
    try {
      final database = await getdatabase();
      final List<Map<String, dynamic>> result = await database.query(
        PersonTable.tablename,
        where: '${PersonTable.cnpj} = ?',
        whereArgs: [username],
      );

      if (result.isNotEmpty) {
        final item = result.first;
        nameuser = item[PersonTable.nomeloja];

        return Person(
          id: item[PersonTable.id],
          cnpj: item[PersonTable.cnpj],
          nomeloja: item[PersonTable.nomeloja],
          senha: item[PersonTable.senha],
        );
      }
      notifyListeners();
      return null;
    } on Exception catch (e) {
      debugPrint('erro no metodo getUser $e');
    }
  }
}
