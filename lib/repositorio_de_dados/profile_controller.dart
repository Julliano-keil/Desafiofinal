import 'package:flutter/material.dart';

import '../entidades/profile.dart';
import 'database/db.dart';

class ProfileController extends ChangeNotifier {
  ProfileController(
      {required this.personid, required this.username, required this.userCnpj});
  final _listProfile = <Profile>[];
  List<Profile> get listProfile => _listProfile;
  String? _controllerImage;
  String? _controllerImageback;
  final int personid;
  Profile? _profileCurrent;
  final String username;
  final String userCnpj;
  final controllerProfile = ProfileControllerdb();

  final formkey = GlobalKey<FormState>();

  final _controllertext = TextEditingController();

  TextEditingController get controllertext => _controllertext;

  String? get controllerImage => _controllerImage;
  String? get controllerImageback => _controllerImageback;

  Future<void> insert() async {
    final profile = Profile(
        userId: personid,
        image: _controllerImage,
        text: _controllertext.text,
        imageback: _controllerImageback);

    await controllerProfile.insert(profile);
    await loadData();
    _controllerImageback = null;
    _controllerImage = null;
    controllertext.clear();
    notifyListeners();
  }

  Future<void> loadData() async {
    final list = await controllerProfile.select(personid);

    listProfile
      ..clear()
      ..addAll(list);
    notifyListeners();
  }

  Future<void> delete() async {
    await controllerProfile.delete(personid);
    await loadData();
    notifyListeners();
  }

  void updateProfile(Profile profile) async {
    _controllerImage = profile.image ?? '';
    _controllerImageback = profile.imageback ?? '';
    _controllertext.text = profile.text.toString();

    _profileCurrent = Profile(
        userId: personid,
        image: profile.image,
        text: profile.text,
        imageback: profile.imageback);
    await loadData();
    notifyListeners();
  }

  Future<void> update() async {
    final profile = Profile(
        id: _profileCurrent?.id,
        userId: personid,
        image: _controllerImage,
        text: controllertext.text,
        imageback: _controllerImageback);

    await controllerProfile.update(profile);
    await loadData();
    _controllerImageback = null;
    _controllerImage = null;
    controllertext.clear();
    notifyListeners();
  }
}
