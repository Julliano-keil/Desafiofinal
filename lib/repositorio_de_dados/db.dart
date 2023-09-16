import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';
import '../entidades/vehicle.dart';

Future<Database> getdatabase() async {
  final path = join(await getDatabasesPath(), 'pessoas.db');

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(PersonTable.createTable);
      await db.execute(AutonomyLeveltable.createTable);
      await db.insert('person', {
        'cnpj': 13878352000190,
        'nomeloja': 'Anderson',
        'senha': 'Anderson'
      });
      await db.execute(VehicleRegistrationTable.createTable);
    },
    version: 3,
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

  static const String tablename = 'person';
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

  Future<void> delete(Person person) async {
    final database = await getdatabase();
    database.delete(PersonTable.tablename,
        where: '${PersonTable.id} = ?', whereArgs: [person.id]);
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

  Future<void> update(Person person) async {
    final database = await getdatabase();

    final map = PersonTable.tomap(person);

    database.update(
      PersonTable.tablename,
      map,
      where: '${PersonTable.id} = ?',
      whereArgs: [person.id],
    );
    return;
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

  Future<void> delete(AutonomyLevel autonomy) async {
    final database = await getdatabase();
    database.delete(AutonomyLeveltable.tablename,
        where: '${AutonomyLeveltable.id} = ?', whereArgs: [autonomy.id]);
  }
}

class VehicleRegistrationTable {
  static const String createTable = '''
    CREATE TABLE $tablename(
    $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $model              TEXT NOT NULL,
      $brand              TEXT NOT NULL,
      $yearManufacture    INTEGER NOT NULL,
      $yearVehicle        INTEGER NOT NULL,
      $image              TEXT NOT NULL,
      $pricePaidShop      REAL NOT NULL,
      $purchaseDate       TEXT NOT NULL
      );
      ''';

  static const String tablename = 'Vehicle_Registration';
  static const String id = 'id';
  static const String model = 'model';
  static const String brand = 'brand';
  static const String yearManufacture = 'year_manufacture';
  static const String yearVehicle = 'year_vehicle';
  static const String image = 'image';
  static const String pricePaidShop = 'price_Paid_Shop';
  static const String purchaseDate = 'purchase_date';

  static Map<String, dynamic> tomap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehicleRegistrationTable.id] = vehicle.id;
    map[VehicleRegistrationTable.model] = vehicle.model;
    map[VehicleRegistrationTable.brand] = vehicle.brand;
    map[VehicleRegistrationTable.yearManufacture] = vehicle.yearManufacture;
    map[VehicleRegistrationTable.yearVehicle] = vehicle.yearVehicle;
    map[VehicleRegistrationTable.image] = vehicle.image;
    map[VehicleRegistrationTable.pricePaidShop] = vehicle.pricePaidShop;
    map[VehicleRegistrationTable.purchaseDate] = vehicle.purchaseDate;
    return map;
  }
}

class VehicleControllerdb {
  Future<void> insert(Vehicle vehicle) async {
    final database = await getdatabase();
    final map = VehicleRegistrationTable.tomap(vehicle);
    await database.insert(VehicleRegistrationTable.tablename, map);
  }

  Future<List<Vehicle>> select() async {
    final database = await getdatabase();
    final List<Map<String, dynamic>> result = await database.query(
      VehicleRegistrationTable.tablename,
    );

    var list = <Vehicle>[];

    for (var item in result) {
      list.add(Vehicle(
          id: item[VehicleRegistrationTable.id],
          model: item[VehicleRegistrationTable.model],
          brand: item[VehicleRegistrationTable.brand],
          yearManufacture: item[VehicleRegistrationTable.yearManufacture],
          yearVehicle: item[VehicleRegistrationTable.yearVehicle],
          image: item[VehicleRegistrationTable.image],
          pricePaidShop: item[VehicleRegistrationTable.pricePaidShop],
          purchaseDate: item[VehicleRegistrationTable.purchaseDate]));
    }
    return list;
  }
}
