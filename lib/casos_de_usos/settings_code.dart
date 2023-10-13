import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// key variable to save in preferences
const appThemeModeKey = 'appThemeMode';

///class responsible for taking care of user configurations
class Settingscode extends ChangeNotifier {
  /// constructor as the init method to start preferences
  Settingscode() {
    unawaited(_init());
  }
  late final SharedPreferences _sharedPreferences;

  var _lightMode = true;

  /// Indicates if the light mode is active.
  bool get ligthMode => _lightMode;

  /// Toggles the theme between light and dark.
  Future<void> toggleTheme() async {
    _lightMode = !_lightMode;
    await _sharedPreferences.setBool(appThemeModeKey, _lightMode);
    notifyListeners();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _lightMode = _sharedPreferences.getBool(appThemeModeKey) ?? true;
    notifyListeners();
  }
}
