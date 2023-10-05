import 'package:flutter/cupertino.dart';

import '../entidades/autonomy_level.dart';

class AutonomyProvider extends ChangeNotifier {
  AutonomyLevel? _userAutonomy;

  AutonomyLevel? get userAutonomy => _userAutonomy;

  void setUserAutonomy(AutonomyLevel autonomy) {
    _userAutonomy = autonomy;
    notifyListeners();
  }
}
