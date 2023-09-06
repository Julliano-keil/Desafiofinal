import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';

Future<Database> getdatabase() async {
  final path = join(await getDatabasesPath(), 'pessoas.db');

  return openDatabase(
    path,
    onCreate: (db, version) async {
      db.execute(PersonTable.createTable);
      db.execute(AutonomyLeveltable.createTable);
    },
    version: 2,
  );
}

class PersonTable {
  static const String createTable = '''
    CREATE TABLE $tablename(
      $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj INTEGER NOT NULL,
      $nomeloja TEXT NOT NULL,
      $senha  TEXT NOT NULL 
    );
    ''';

  static const String tablename = 'pessoa';
  static const String id = 'id';
  static const String cnpj = 'cnpj';
  static const String nomeloja = 'nomeloja';
  static const String senha = 'senha';

  static Map<String, dynamic> tomap(Person person) {
    final map = <String, dynamic>{};

    map[PersonTable.id] = person.id;
    map[PersonTable.cnpj] = person.cnpj;
    map[PersonTable.nomeloja] = person.nomeloja;
    map[PersonTable.senha] = person.senha;

    return map;
  }
}

class PessoaControler {
  Future<void> insert(Person person) async {
    final database = await getdatabase();
    final map = PersonTable.tomap(person);
    await database.insert(PersonTable.tablename, map);

    return;
  }

  Future<List<Person>> select() async {
    final database = await getdatabase();
    final List<Map<String, dynamic>> result = await database.query(
      PersonTable.tablename,
    );

    var list = <Person>[];

    for (var item in result) {
      list.add(Person(
        id: item[PersonTable.id],
        cnpj: item[PersonTable.cnpj],
        nomeloja: item[PersonTable.nomeloja],
        senha: item[PersonTable.senha],
      ));
    }
    return list;
  }
}

class AutonomyLeveltable {
  static const String createTable = '''
    CREATE TABLE $tablename(
      $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $personid INTEGER NOT NULL,
      $name TEXT NOT NULL,
      $networkPercentage REAL NOT NULL,
      $networkSecurity REAL NOT NULL,
      $storePercentage  REAL NOT NULL 
    );
    ''';

  static const String tablename = 'autonomy_level';
  static const String id = 'id';
  static const String personid = 'id_person';
  static const String name = 'name';
  static const String networkSecurity = 'network_Security';
  static const String storePercentage = 'store_Percentage';
  static const String networkPercentage = 'networkPercentage';

  static Map<String, dynamic> tomap(AutonomyLevel autonomylavel) {
    final map = <String, dynamic>{};

    map[AutonomyLeveltable.id] = autonomylavel.id;
    map[AutonomyLeveltable.personid] = autonomylavel.personID;
    map[AutonomyLeveltable.name] = autonomylavel.name;
    map[AutonomyLeveltable.networkPercentage] = autonomylavel.networkPercentage;
    map[AutonomyLeveltable.networkSecurity] = autonomylavel.networkSecurity;
    map[AutonomyLeveltable.storePercentage] = autonomylavel.storePercentage;

    return map;
  }
}

class AutonomyControler {
  Future<void> insert(AutonomyLevel autonomy) async {
    final database = await getdatabase();
    final map = AutonomyLeveltable.tomap(autonomy);
    await database.insert(AutonomyLeveltable.tablename, map);
  }

  Future<List<AutonomyLevel>> select(int personID) async {
    final database = await getdatabase();
    final List<Map<String, dynamic>> result = await database.query(
        AutonomyLeveltable.tablename,
        where: '${AutonomyLeveltable.personid} = ?',
        whereArgs: [personID]);

    var list = <AutonomyLevel>[];

    for (var item in result) {
      list.add(AutonomyLevel(
          id: item[AutonomyLeveltable.id],
          personID: item[AutonomyLeveltable.personid],
          name: item[AutonomyLeveltable.name],
          networkSecurity: item[AutonomyLeveltable.networkSecurity],
          storePercentage: item[AutonomyLeveltable.storePercentage],
          networkPercentage: item[AutonomyLeveltable.networkPercentage]));
    }
    return list;
  }
}
