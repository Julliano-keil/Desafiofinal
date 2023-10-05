import 'package:flutter/cupertino.dart';

import '../entidades/autonomy_level.dart';

class AutonomyProvider extends ChangeNotifier {
  AutonomyProvider(List<AutonomyLevel> autonomyList) {
    setUserAutonomyList(autonomyList);
  }

  List<AutonomyLevel>? _userAutonomyList;
  String? _autonomyName;
  double? _securityPercentage;
  double? _storePercentage;
  double? _networkPercentage;

  List<AutonomyLevel>? get userAutonomyList => _userAutonomyList;
  String? get autonomyName => _autonomyName;
  double? get securityPercentage => _securityPercentage;
  double? get storePercentage => _storePercentage;
  double? get networkPercentage => _networkPercentage;

  void setUserAutonomyList(List<AutonomyLevel> autonomyList) {
    _userAutonomyList = autonomyList;

    if (autonomyList.isNotEmpty) {
      final firstAutonomyLevel = autonomyList.first;
      _autonomyName = firstAutonomyLevel.name;
      _securityPercentage = firstAutonomyLevel.networkSecurity;
      _storePercentage = firstAutonomyLevel.storePercentage;
      _networkPercentage = firstAutonomyLevel.networkPercentage;
    }

    notifyListeners();
  }
}
