import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../entidades/profile.dart';
import 'database/db.dart';

class ProfileController extends ChangeNotifier {
  ProfileController({required this.personid}) {
    unawaited(loadData());
    unawaited(dataAutonomy(personid));
  }
  final _listProfile = <Profile>[];
  List<Profile> get listProfile => _listProfile;
  String? _controllerImage;
  String? _controllerImageback;
  final int personid;
  Profile? _profileCurrent;
  Profile? userpro;

  String? image;
  String? imageback;
  String? textUser;
  int? userid;

  double? dealershipPercentag;
  double? businessPercentag;
  double? safetyPercentag;
  String? nameautonomy;
  final controllerAutonomy = AutonomyControler();

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

    if (list.isNotEmpty) {
      userid = list[0].userId;
      image = list[0].image;
      imageback = list[0].imageback;
      textUser = list[0].text;
      userpro = Profile(
          userId: userid!, image: image, text: textUser!, imageback: imageback);

      listProfile.clear();
      listProfile.addAll(list);
    }
    notifyListeners();
  }

  Future<void> dataAutonomy(int idperson) async {
    final list = await controllerAutonomy.select(idperson);

    if (list.isNotEmpty) {
      nameautonomy = list[0].name;
      dealershipPercentag = list[0].networkPercentage;
      businessPercentag = list[0].storePercentage;
      safetyPercentag = list[0].networkSecurity;
    }
    notifyListeners();
  }

  Future<void> delete(int userid) async {
    await controllerProfile.delete(userid);
    await loadData();
    notifyListeners();
  }

  void updateProfile(Profile profile) async {
    _controllerImage = profile.image ?? '';
    _controllerImageback = profile.imageback ?? '';
    _controllertext.text = profile.text.toString();

    _profileCurrent = Profile(
        id: _profileCurrent?.id,
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

  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllerImage = image.path;
    }
    notifyListeners();
  }

  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerImage = image.path;
      notifyListeners();
    }
  }

  Future pickImageback() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllerImageback = image.path;
    }
    notifyListeners();
  }

  Future takePhotoback() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerImageback = image.path;
      notifyListeners();
    }
  }
}
