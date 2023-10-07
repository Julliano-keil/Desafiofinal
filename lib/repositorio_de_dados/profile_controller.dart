import 'package:flutter/material.dart';

import '../entidades/profile.dart';
import 'database/db.dart';

class ProfileController {
  final _listProfile = <Profile>[];
  List<Profile> get listProfile => _listProfile;
  String? _controllerImage;
  String? _controllerImageback;

  final controllerProfile = ProfileControllerdb();

  final formkey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllertext = TextEditingController();

  TextEditingController get controllerName => _controllerName;
  TextEditingController get controllertext => _controllertext;

  String? get controllerImage => _controllerImage;
  String? get controllerImageback => _controllerImageback;

  Future<void>
}
