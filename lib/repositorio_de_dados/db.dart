import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entidades/autonomy_Lavel.dart';
import '../entidades/person.dart';

Future<Database> getdatabase() async {
  final path = join(await getDatabasesPath(), 'pessoas.db');

  return openDatabase(
    path,
    onCreate: (db, version) async {
      db.execute(PersonTable.createTable);
      db.execute(AutonomyLaveltable.createTable);
    },
    version: 1,
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

class AutonomyLaveltable {
  static const String createTable = '''
    CREATE TABLE $tablename(
      $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $name TEXT NOT NULL,
      $networkPercentage REAL NOT NULL,
      $networkSecurity REAL NOT NULL,
      $storePercentage  REAL NOT NULL 
    );
    ''';

  static const String tablename = 'autonomy_lavel';
  static const String id = 'id';
  static const String name = 'name';
  static const String networkSecurity = 'network_Security';
  static const String storePercentage = 'store_Percentage';
  static const String networkPercentage = 'networkPercentage';

  static Map<String, dynamic> tomap(AutonomyLevel autonomylavel) {
    final map = <String, dynamic>{};

    map[AutonomyLaveltable.id] = autonomylavel.id;
    map[AutonomyLaveltable.name] = autonomylavel.name;
    map[AutonomyLaveltable.networkPercentage] = autonomylavel.networkPercentage;
    map[AutonomyLaveltable.networkSecurity] = autonomylavel.networkSecurity;
    map[AutonomyLaveltable.storePercentage] = autonomylavel.storePercentage;

    return map;
  }
}

class AutonomyControler {
  Future<void> insert(Person person) async {
    final database = await getdatabase();
    final map = PersonTable.tomap(person);
    await database.insert(PersonTable.tablename, map);

    return;
  }

  Future<List<AutonomyLevel>> select() async {
    final database = await getdatabase();
    final List<Map<String, dynamic>> result = await database.query(
      AutonomyLaveltable.tablename,
    );

    var list = <AutonomyLevel>[];

    for (var item in result) {
      list.add(AutonomyLevel(
          name: item[AutonomyLaveltable.name],
          networkSecurity: item[AutonomyLaveltable.networkSecurity],
          storePercentage: item[AutonomyLaveltable.storePercentage],
          networkPercentage: item[AutonomyLaveltable.networkPercentage]));
    }
    return list;
  }
}
