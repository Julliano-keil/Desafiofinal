import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../entidades/autonomy_level.dart';
import '../entidades/person.dart';

import '../widgets/dialog.dart';
import 'db.dart';

class AutonomilevelControler extends ChangeNotifier {
  AutonomilevelControler({required this.person}) {
    loadata();
  }

  final Person person;
  final controller = AutonomyControler();
  final formkey = GlobalKey<FormState>();
  final _listaAutonomy = <AutonomyLevel>[];
  List<AutonomyLevel> get listaAutonomy => _listaAutonomy;
  final _controllerNameNivel = TextEditingController();
  final _controllerNetworkSecurity = TextEditingController();
  final _controllerStorePercentage = TextEditingController();
  final _controllerNetworkPercentage = TextEditingController();

  TextEditingController get controllerNameNivel => _controllerNameNivel;
  TextEditingController get controllerNetworkSecurity =>
      _controllerNetworkSecurity;
  TextEditingController get controllerStorePercentag =>
      _controllerStorePercentage;
  TextEditingController get controllerNetworkPercentage =>
      _controllerNetworkPercentage;

  Future<void> insert() async {
    try {
      if (listaAutonomy.isNotEmpty) {
        print('ja cadastrado! ');
      } else if (person.id != null) {
        final autonomy = AutonomyLevel(
          name: _controllerNameNivel.text,
          networkSecurity: double.parse(_controllerNetworkSecurity.text),
          storePercentage: double.parse(_controllerStorePercentage.text),
          networkPercentage: double.parse(_controllerNetworkPercentage.text),
          personID: person.id ?? 0,
        );
        print('id 1 ${autonomy.personID}');
        print('id 2${person.id}');
        await controller.insert(autonomy);
        print(autonomy.networkPercentage);
        controllerNameNivel.clear();
        controllerNetworkPercentage.clear();
        controllerNetworkSecurity.clear();
        controllerStorePercentag.clear();
        loadata();
        print('id 3${autonomy.personID}');
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint('erro nometodo insert Erro=> $e');
    }
  }

  Future<void> loadata() async {
    final list = await controller.select(person.id ?? 0);

    listaAutonomy.clear();
    listaAutonomy.addAll(list);
    print('lista -- ${list.length}');

    notifyListeners();
  }

  void cleanController() {
    controllerNameNivel.clear();
    controllerNetworkPercentage.clear();
    controllerNetworkSecurity.clear();
    controllerStorePercentag.clear();
    loadata();
    notifyListeners();
  }

  Future<void> delete(AutonomyLevel autonomy) async {
    try {
      await controller.delete(autonomy);
      await loadata();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(' erro no metodo delet $e');
    }
  }
}
