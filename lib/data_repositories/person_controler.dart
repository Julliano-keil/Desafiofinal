import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';
import 'database/db.dart';

/// A controller class for managing persons and user information.
class PersonControler extends ChangeNotifier {
  /// Constructor for initializing the PersonControler.
  PersonControler() {
    unawaited(loadata());
  }

  ///The name of the user.
  String nameuser = '';

  ///controller of person the data base
  final constroller = PessoaControler();

  ///controller of autonomy the data base
  final controllerAutonomy = AutonomyControler();
  final _listaPeople = <Person>[];
  final _listAutomomydata = <AutonomyLevel>[];

  ///get person list
  List<Person> get listaPeople => _listaPeople;

  ///get autonomy list
  List<AutonomyLevel> get listAutonomydata => _listAutomomydata;

  ///valid the person form
  final formKey = GlobalKey<FormState>();
  final _controllerCnpj = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerSenha = TextEditingController();

  ///get value from the cnpj entered by the user
  TextEditingController get controllerCnpj => _controllerCnpj;

  /// get value from the name entered by the user
  TextEditingController get controllerName => _controllerName;

  ///get value from the password entered by the user
  TextEditingController get controllerSenha => _controllerSenha;

  ///inserts the person object into the database
  Future<void> insert() async {
    try {
      final people = Person(
          id: null,
          cnpj: _controllerCnpj.text,
          storeName: _controllerName.text,
          password: _controllerSenha.text);

      await constroller.insert(people);
      controllerCnpj.clear();
      controllerName.clear();
      controllerSenha.clear();
      await loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo insert $e');
    }
  }

  /// reload perosn list
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

  ///valid login user go home page
  Future<dynamic> getUserByUsercnpj(String usercnpj) async {
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
          storeName: item[PersonTable.nomeloja],
          password: item[PersonTable.senha],
        );
      }
      notifyListeners();
      return null;
    } on Exception catch (e) {
      debugPrint('erro no metodo getUser $e');
    }
  }

  Person? _loggedUser;

  ///get user current
  Person? get loggedUser => _loggedUser;

  ///save preferences user current
  Future<void> saveUserInfo(
      int userId, String userName, String userCnpj) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('userName', userName);
    await prefs.setString('userCnpj', userCnpj);
    notifyListeners();
  }

  /// reload user current
  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final userName = prefs.getString('userName');
    final userCnpj = prefs.getString('userCnpj');
    if (userId != null && userName != null) {
      _loggedUser = Person(
        id: userId,
        cnpj: userCnpj,
        storeName: userName,
        password: '',
      );
      notifyListeners();
    }
  }

  ///get datatime of user
  String? dataTimeNow;

  /// method for get datatime
  Future<void> getdate() async {
    final prefs = await SharedPreferences.getInstance();
    dataTimeNow = prefs.getString('lastLoginTime');
    notifyListeners();
  }

  ///loud data time of user
  Future<void> louddata() async {
    final prefs = await SharedPreferences.getInstance();
    var currentTime = DateTime.now().toString();
    await prefs.setString('lastLoginTime', currentTime);
    dataTimeNow = currentTime;

    notifyListeners();
  }

  /// clear preferences user
  Future<void> clearUserInfo() async {
    await loadata();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
