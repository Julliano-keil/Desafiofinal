import 'dart:async';
import 'dart:core';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../entidades/autonomy_level.dart';
import '../../entidades/person.dart';
import '../../entidades/profile.dart';
import '../../entidades/sales.dart';
import '../../entidades/vehicle.dart';

/// method to execute and create tables in the database
Future<Database> getdatabase() async {
  final path = join(await getDatabasesPath(), 'pessoas.db');

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(PersonTable.createTable);
      await db.execute(AutonomyLeveltable.createTable);
      await db.insert(
        'person',
        {
          'cnpj': '13.878.352/0001-90',
          'storeName': 'Anderson',
          'password': 'Anderson'
        },
      );
      await db.execute(VehicleRegistrationTable.createTable);
      await db.execute(SalesTable.createTable);
      await db.execute(ProfileUserTable.createTable);
    },
    version: 11,
  );
}

///person table class
class PersonTable {
  /// var create table
  static const String createTable = '''
    CREATE TABLE $tablename(
      $id                INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj              TEXT NOT NULL,
      $nomeloja          TEXT NOT NULL,
      $senha             TEXT NOT NULL 
    );
    ''';

  ///table name
  static const String tablename = 'person';

  ///table id
  static const String id = 'id';

  ///user cnpj
  static const String cnpj = 'cnpj';

  ///store name
  static const String nomeloja = 'storeName';

  ///store password
  static const String senha = 'password';

  ///maps the database and assigns the value to the entity
  static Map<String, dynamic> tomap(Person person) {
    final map = <String, dynamic>{};

    map[PersonTable.id] = person.id;
    map[PersonTable.cnpj] = person.cnpj;
    map[PersonTable.nomeloja] = person.storeName;
    map[PersonTable.senha] = person.password;
    return map;
  }
}

///person table controller
class PessoaControler {
  ///insert data into the table person
  Future<void> insert(Person person) async {
    final database = await getdatabase();
    final map = PersonTable.tomap(person);
    await database.insert(PersonTable.tablename, map);
    return;
  }

  ///delete person by id
  Future<void> delete(Person person) async {
    final database = await getdatabase();
    unawaited(database.delete(PersonTable.tablename,
        where: '${PersonTable.id} = ?', whereArgs: [person.id]));
  }

  ///select all person
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
        storeName: item[PersonTable.nomeloja],
        password: item[PersonTable.senha],
      ));
    }
    return list;
  }

  ///update table data
  Future<void> update(Person person) async {
    final database = await getdatabase();

    final map = PersonTable.tomap(person);

    unawaited(database.update(
      PersonTable.tablename,
      map,
      where: '${PersonTable.id} = ?',
      whereArgs: [person.id],
    ));
    return;
  }
}

///database table that contains the user level
class AutonomyLeveltable {
  ///create table and pass the variable type
  static const String createTable = '''
    CREATE TABLE $tablename(
      $id                 INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $personid           INTEGER NOT NULL,
      $name               TEXT NOT NULL,
      $networkPercentage  REAL NOT NULL,
      $networkSecurity    REAL NOT NULL,
      $storePercentage    REAL NOT NULL 
    );
    ''';

  ///table name
  static const String tablename = 'autonomy_level';

  ///autonomy id
  static const String id = 'id';

  ///user id
  static const String personid = 'id_person';

  /// user store name
  static const String name = 'name';

  /// box security
  static const String networkSecurity = 'network_Security';

  /// store commotion
  static const String storePercentage = 'store_Percentage';

  ///affiliate commission
  static const String networkPercentage = 'networkPercentage';

  ///maps the database and assigns the value to the entity
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

///autonomy table controller
class AutonomyControler {
  ///insert data into the database in the autonomy table
  Future<void> insert(AutonomyLevel autonomy) async {
    final database = await getdatabase();
    final map = AutonomyLeveltable.tomap(autonomy);
    await database.insert(AutonomyLeveltable.tablename, map);
  }

  /// select all autnonomy table by id
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

  /// delete autonomy table by id
  Future<void> delete(AutonomyLevel autonomy) async {
    final database = await getdatabase();
    await database.delete(AutonomyLeveltable.tablename,
        where: '${AutonomyLeveltable.id} = ?', whereArgs: [autonomy.id]);
  }

  /// update table by id
  Future<void> update(AutonomyLevel autonomy) async {
    final database = await getdatabase();

    final map = AutonomyLeveltable.tomap(autonomy);

    await database.update(
      AutonomyLeveltable.tablename,
      map,
      where: '${AutonomyLeveltable.id} = ?',
      whereArgs: [autonomy.id],
    );
    return;
  }
}

///database table containing registered vehicles
class VehicleRegistrationTable {
  /// variable with responsibility for creating the
  /// table and passing the values ​​to the variables
  static const String createTable = '''
    CREATE TABLE $tablename(
      $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $idperson INTEGER NOT NULL,
      $model              TEXT NOT NULL,
      $nameUser           TEXT NOT NULL,
      $brand              TEXT NOT NULL,
      $yearManufacture    TEXT NOT NULL,
      $yearVehicle        TEXT NOT NULL,
      $image              TEXT NOT NULL,
      $pricePaidShop      REAL NOT NULL,
      $purchaseDate       TEXT NOT NULL
      );
      ''';

  ///table name
  static const String tablename = 'Vehicle_Registration';

  ///vehicle identification
  static const String id = 'id';

  ///ID of the person who registered the car with the bank
  static const String idperson = 'idperson';

  ///model vehicle
  static const String model = 'model';

  ///brand vehicle
  static const String brand = 'brand';

  ///vehicle manufacturing date
  static const String yearManufacture = 'year_manufacture';

  ///vehicle date
  static const String yearVehicle = 'year_vehicle';

  /// vehicle image
  static const String image = 'image';

  ///vehicle price
  static const String pricePaidShop = 'price_Paid_Shop';

  ///sale date
  static const String purchaseDate = 'purchase_date';

  /// buyer's name
  static const String nameUser = 'name_user';

  ///maps the database and assigns the value to the entity
  static Map<String, dynamic> tomap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehicleRegistrationTable.id] = vehicle.id;
    map[VehicleRegistrationTable.idperson] = vehicle.idperson;
    map[VehicleRegistrationTable.model] = vehicle.model;
    map[VehicleRegistrationTable.brand] = vehicle.brand;
    map[VehicleRegistrationTable.yearManufacture] = vehicle.yearManufacture;
    map[VehicleRegistrationTable.yearVehicle] = vehicle.yearVehicle;
    map[VehicleRegistrationTable.image] = vehicle.image;
    map[VehicleRegistrationTable.pricePaidShop] = vehicle.pricePaidShop;
    map[VehicleRegistrationTable.purchaseDate] = vehicle.purchaseDate;
    map[VehicleRegistrationTable.nameUser] = vehicle.nameUser;
    return map;
  }
}

///vehicle table controller
class VehicleControllerdb {
  ///insert data into the vehicle table
  Future<void> insert(Vehicle vehicle) async {
    final database = await getdatabase();
    final map = VehicleRegistrationTable.tomap(vehicle);
    await database.insert(VehicleRegistrationTable.tablename, map);
  }

  ///select all vehicles from the table by id
  Future<List<Vehicle>> select(int personid) async {
    final database = await getdatabase();
    final List<Map<String, dynamic>> result = await database.query(
      VehicleRegistrationTable.tablename,
      where: '${VehicleRegistrationTable.idperson} = ?',
      whereArgs: [personid],
    );

    var list = <Vehicle>[];

    for (var item in result) {
      list.add(
        Vehicle(
          id: item[VehicleRegistrationTable.id],
          idperson: item[VehicleRegistrationTable.idperson],
          model: item[VehicleRegistrationTable.model],
          brand: item[VehicleRegistrationTable.brand],
          yearManufacture: item[VehicleRegistrationTable.yearManufacture],
          yearVehicle: item[VehicleRegistrationTable.yearVehicle],
          image: item[VehicleRegistrationTable.image],
          pricePaidShop: item[VehicleRegistrationTable.pricePaidShop],
          purchaseDate: item[VehicleRegistrationTable.purchaseDate],
          nameUser: item[VehicleRegistrationTable.nameUser],
        ),
      );
    }
    return list;
  }

  ///select all vehicle table
  Future<List<Vehicle>> selectlist() async {
    final database = await getdatabase();
    final List<Map<String, dynamic>> result =
        await database.query(VehicleRegistrationTable.tablename);

    var list = <Vehicle>[];

    for (var item in result) {
      list.add(
        Vehicle(
          id: item[VehicleRegistrationTable.id],
          idperson: item[VehicleRegistrationTable.idperson],
          model: item[VehicleRegistrationTable.model],
          brand: item[VehicleRegistrationTable.brand],
          yearManufacture: item[VehicleRegistrationTable.yearManufacture],
          yearVehicle: item[VehicleRegistrationTable.yearVehicle],
          image: item[VehicleRegistrationTable.image],
          pricePaidShop: item[VehicleRegistrationTable.pricePaidShop],
          purchaseDate: item[VehicleRegistrationTable.purchaseDate],
          nameUser: item[VehicleRegistrationTable.nameUser],
        ),
      );
    }
    return list;
  }

  ///delete vehicle table by id
  Future<void> delete(Vehicle vehicle) async {
    final database = await getdatabase();

    await database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          VehicleRegistrationTable.tablename,
          where: '${VehicleRegistrationTable.id} = ?',
          whereArgs: [vehicle.id],
        );

        batch.delete(
          SalesTable.tableName,
          where: '${SalesTable.vehicleId} = ?',
          whereArgs: [vehicle.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}

///database table containing recorded sales
class SalesTable {
  /// variable with responsibility for creating the
  /// table and passing the values ​​to the variables
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $customerCpf    TEXT NOT NULL,
      $userCnpj       TEXT NOT NULL,
      $model          TEXT NOT NULL,
      $brand          TEXT NOT NULL,
      $customerName   TEXT NOT NULL,
      $nameUser       TEXT NOT NULL,
      $soldWhen       TEXT NOT NULL,
      $priceSold      REAL NOT NULL,
      $dealershipCut  REAL NOT NULL,
      $businessCut    REAL NOT NULL,
      $safetyCut      REAL NOT NULL,
      $vehicleId      INTERGER NOT NULL,
      $userId         INTEGER NOT NULL,
      $yearVehicle    TEXT NOT NULL   
    );
  ''';

  ///table name
  static const String tableName = 'sale';

  ///ID of the person who registered the sale
  static const String id = 'id';

  ///CPF of the person who made the purchase
  static const String customerCpf = 'customer_cpf';

  ///name of the person who made the purchase
  static const String customerName = 'customer_name';

  /// date of sale
  static const String soldWhen = 'sold_when';

  /// sold price
  static const String priceSold = 'price_sold';

  /// affiliate commission
  static const String dealershipCut = 'dealership_cut';

  ///store commission
  static const String businessCut = 'business_cut';

  /// safety porcentage
  static const String safetyCut = 'safety_cut';

  /// vehicle id
  static const String vehicleId = 'vehicle_id';

  ///name of the person who registered the sale
  static const String nameUser = 'name_user';

  ///ID of the person who castrated the sale
  static const String userId = 'user_id';

  ///brand vehicle
  static const String brand = 'brand';

  ///model vehicle
  static const String model = 'model';

  /// user cnpj
  static const String userCnpj = 'user_cnpj';

  /// date vehicle
  static const String yearVehicle = 'year_vehicle';

  /// maps the database and assigns the value to the entity
  static Map<String, dynamic> toMap(Sale sale) {
    final map = <String, dynamic>{};

    map[SalesTable.id] = sale.id;
    map[SalesTable.nameUser] = sale.nameUser;
    map[SalesTable.customerCpf] = sale.customerCpf;
    map[SalesTable.customerName] = sale.customerName;
    map[SalesTable.soldWhen] = sale.soldWhen;
    map[SalesTable.priceSold] = sale.priceSold;
    map[SalesTable.dealershipCut] = sale.dealershipPercentage;
    map[SalesTable.businessCut] = sale.businessPercentage;
    map[SalesTable.safetyCut] = sale.safetyPercentage;
    map[SalesTable.vehicleId] = sale.vehicleId;
    map[SalesTable.userId] = sale.userId;
    map[SalesTable.userCnpj] = sale.userCnpj;
    map[SalesTable.model] = sale.model;
    map[SalesTable.brand] = sale.brand;
    map[SalesTable.yearVehicle] = sale.plate;

    return map;
  }
}

/// sale table controller
class SaleTableController {
  ///insert sale class tables into the database
  Future<void> insert(Sale sale) async {
    final database = await getdatabase();
    final map = SalesTable.toMap(sale);
    await database.insert(SalesTable.tableName, map);
  }

  ///delete sale table by id
  Future<void> delete(Sale sale) async {
    final database = await getdatabase();

    await database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          SalesTable.tableName,
          where: '${SalesTable.id} = ?',
          whereArgs: [sale.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  /// select  sale table
  Future<List<Sale>> select() async {
    final database = await getdatabase();

    final List<Map<String, dynamic>> result =
        await database.query(SalesTable.tableName);

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          nameUser: item[SalesTable.nameUser],
          customerCpf: item[SalesTable.customerCpf],
          customerName: item[SalesTable.customerName],
          soldWhen: item[SalesTable.soldWhen],
          priceSold: item[SalesTable.priceSold],
          dealershipPercentage: item[SalesTable.dealershipCut],
          businessPercentage: item[SalesTable.businessCut],
          safetyPercentage: item[SalesTable.safetyCut],
          vehicleId: item[SalesTable.vehicleId],
          userId: item[SalesTable.userId],
          brand: item[SalesTable.brand],
          model: item[SalesTable.model],
          userCnpj: item[SalesTable.userCnpj],
          plate: item[SalesTable.yearVehicle],
        ),
      );
    }
    return list;
  }

  /// select all sale table by id
  Future<List<Sale>> selectlist(int idperson) async {
    final database = await getdatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${SalesTable.userId} = ?',
      whereArgs: [idperson],
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          nameUser: item[SalesTable.nameUser],
          customerCpf: item[SalesTable.customerCpf],
          customerName: item[SalesTable.customerName],
          soldWhen: item[SalesTable.soldWhen],
          priceSold: item[SalesTable.priceSold],
          dealershipPercentage: item[SalesTable.dealershipCut],
          businessPercentage: item[SalesTable.businessCut],
          safetyPercentage: item[SalesTable.safetyCut],
          vehicleId: item[SalesTable.vehicleId],
          userId: item[SalesTable.userId],
          brand: item[SalesTable.brand],
          model: item[SalesTable.model],
          userCnpj: item[SalesTable.userCnpj],
          plate: item[SalesTable.yearVehicle],
        ),
      );
    }
    return list;
  }

  /// get the latest sale
  Future<List<Sale>> selectlatest(int idperson) async {
    final database = await getdatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${SalesTable.userId} = ?',
      whereArgs: [idperson],
      orderBy: '${SalesTable.soldWhen} DESC',
      limit: 1,
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          nameUser: item[SalesTable.nameUser],
          customerCpf: item[SalesTable.customerCpf],
          customerName: item[SalesTable.customerName],
          soldWhen: item[SalesTable.soldWhen],
          priceSold: item[SalesTable.priceSold],
          dealershipPercentage: item[SalesTable.dealershipCut],
          businessPercentage: item[SalesTable.businessCut],
          safetyPercentage: item[SalesTable.safetyCut],
          vehicleId: item[SalesTable.vehicleId],
          userId: item[SalesTable.userId],
          brand: item[SalesTable.brand],
          model: item[SalesTable.model],
          userCnpj: item[SalesTable.userCnpj],
          plate: item[SalesTable.yearVehicle],
        ),
      );
    }
    return list;
  }

  /// update sale table by id
  Future<void> update(Sale sale) async {
    final database = await getdatabase();

    final map = SalesTable.toMap(sale);

    await database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          SalesTable.tableName,
          map,
          where: '${SalesTable.tableName} = ?',
          whereArgs: [sale.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}

///tabela no banco de dados contendo o perfil do usuário
class ProfileUserTable {
  /// maps the database and assigns the value to the entity
  static const String createTable = '''
  CREATE TABLE $tableName(
  $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $image          TEXT NOT NULL,
  $userId         INTEGER NOT NULL
  ); 
''';

  ///table name
  static const String tableName = 'Profile';

  /// table id
  static const String id = 'id';

  ///user profile id
  static const String userId = 'userid';

  ///user photo
  static const String image = 'image';

  /// maps the database and assigns the value to the entity
  static Map<String, dynamic> toMap(Profile profile) {
    final map = <String, dynamic>{};
    map[ProfileUserTable.id] = profile.id;
    map[ProfileUserTable.image] = profile.image;
    map[ProfileUserTable.userId] = profile.userId;

    return map;
  }
}

/// table controller profile
class ProfileControllerdb {
  ///insert data from the profile table into the database
  Future<void> insert(Profile profile) async {
    final database = await getdatabase();
    final map = ProfileUserTable.toMap(profile);
    await database.insert(ProfileUserTable.tableName, map);
  }

  /// select profile table by id
  Future<List<Profile>> select(int personid) async {
    final database = await getdatabase();
    final List<Map<String, dynamic>> result = await database.query(
      ProfileUserTable.tableName,
      where: '${ProfileUserTable.userId} = ?',
      whereArgs: [personid],
    );

    var list = <Profile>[];

    for (var item in result) {
      list.add(
        Profile(
          id: item[ProfileUserTable.id],
          userId: item[ProfileUserTable.userId],
          image: item[ProfileUserTable.image],
        ),
      );
    }
    return list;
  }

  /// delete profile table by id
  Future<void> delete(int userid) async {
    final database = await getdatabase();
    unawaited(database.delete(ProfileUserTable.tableName,
        where: '${ProfileUserTable.userId} = ?', whereArgs: [userid]));
  }

  /// update profile table by id
  Future<void> update(Profile profile) async {
    final database = await getdatabase();

    final map = ProfileUserTable.toMap(profile);

    unawaited(database.update(
      ProfileUserTable.tableName,
      map,
      where: '${ProfileUserTable.id} = ?',
      whereArgs: [profile.id],
    ));
    return;
  }
}
