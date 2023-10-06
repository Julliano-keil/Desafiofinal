import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../casos_de_usos/autonomy_data.dart';
import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';
import 'database/db.dart';

class PersonControler extends ChangeNotifier {
  PersonControler() {
    unawaited(loadata());
    unawaited(loadUserInfo());
    //unawaited(clearUserInfo());
  }
  String nameuser = '';

  final constroller = PessoaControler();
  final controllerAutonomy = AutonomyControler();
  final _listaPeople = <Person>[];
  final _listAutomomydata = <AutonomyLevel>[];
  List<Person> get listaPeople => _listaPeople;
  final autonomyProvider = AutonomyProvider([]);
  List<AutonomyLevel> get listAutonomydata => _listAutomomydata;
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
          id: null,
          cnpj: _controllerCnpj.text,
          nomeloja: _controllerName.text,
          senha: _controllerSenha.text);

      await constroller.insert(people);
      controllerCnpj.clear();
      controllerName.clear();
      controllerNivel.clear();
      controllerSenha.clear();
      await loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo insert $e');
    }
  }

  Future<void> dataAutonomy(int idperson) async {
    try {
      final list = await controllerAutonomy.select(idperson);

      if (list.isNotEmpty) {
        autonomyProvider.setUserAutonomyList(list);
      }
    } on Exception catch (e) {
      debugPrint('erro no metodo de listauto $e');
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

  Future<dynamic> getUserByUsername(String usercnpj) async {
    try {
      final database = await getdatabase();
      final List<Map<String, dynamic>> result = await database.query(
        PersonTable.tablename,
        where: '${PersonTable.cnpj} = ?',
        whereArgs: [usercnpj],
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

  Person? _loggedUser;
  Person? get loggedUser => _loggedUser;

  void setLoggedUser(Person? user) {
    _loggedUser = user;
    notifyListeners();
  }

  Future<void> saveUserInfo(
      int userId, String userName, String userCnpj) async {
    await loadata();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('userName', userName);
    await prefs.setString('userCnpj', userCnpj);
  }

  Future<void> loadUserInfo() async {
    await loadata();
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final userName = prefs.getString('userName');
    final userCnpj = prefs.getString('userCnpj');

    if (userId != null && userName != null) {
      _loggedUser = Person(
        id: userId,
        cnpj: userCnpj,
        nomeloja: userName,
        senha: '',
      );

      notifyListeners();
    }
  }

  Future<void> clearUserInfo() async {
    await loadata();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
