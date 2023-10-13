import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../entidades/profile.dart';
import 'database/db.dart';

///  manages the state of the Profileuser class
class ProfileController extends ChangeNotifier {
  ///responsible for collecting mandatory variables
  ProfileController({required this.personid}) {
    unawaited(loadData());
    unawaited(dataAutonomy(personid));
  }
  final _listProfile = <Profile>[];

  ///get the profile list
  List<Profile> get listProfile => _listProfile;
  String? _controllerImage;

  /// get user id current
  final int personid;
  Profile? _profileCurrent;

  /// object with information user current
  Profile? userpro;

  ///image current
  String? image;

  /// user current
  int? userid;

  /// id profile current
  int? id;

  ///shows autonomy of user current
  double? dealershipPercentag;

  ///
  double? businessPercentag;

  ///
  double? safetyPercentag;

  ///
  String? nameautonomy;

  ///controller the autonomy table of data base
  final controllerAutonomy = AutonomyControler();

  ///controller the profile table of data base
  final controllerProfile = ProfileControllerdb();

  /// get image typed user
  String? get controllerImage => _controllerImage;

  /// insert profile table of data base
  Future<void> insert() async {
    final profile = Profile(
      userId: personid,
      image: _controllerImage,
    );

    await controllerProfile.insert(profile);

    _controllerImage = null;

    await loadData();
    notifyListeners();
  }

  ///reload profile list and fill userpro with user information
  Future<void> loadData() async {
    final list = await controllerProfile.select(personid);

    if (list.isNotEmpty) {
      id = list[0].id;
      userid = list[0].userId;
      image = list[0].image;
      userpro = Profile(
        id: id,
        userId: userid!,
        image: image,
      );

      listProfile.clear();
      listProfile.addAll(list);
    }
    notifyListeners();
  }

  /// reload current user autonomy information
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

  /// delete profile
  Future<void> delete(int userid) async {
    await controllerProfile.delete(userid);
    await loadData();
    notifyListeners();
  }

  /// populace current profile
  void updateProfile(Profile profile) async {
    _controllerImage = profile.image ?? '';
    _profileCurrent = Profile(
      id: id,
      userId: personid,
      image: profile.image,
    );
    await loadData();
    notifyListeners();
  }

  /// update profile current
  Future<void> update() async {
    final profile = Profile(
      id: _profileCurrent?.id,
      userId: personid,
      image: _controllerImage,
    );

    await controllerProfile.update(profile);

    _controllerImage = null;

    await loadData();
    notifyListeners();
  }

  ///get image of user's gallery
  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllerImage = image.path;
    }
    notifyListeners();
  }

  ///get image of user's camera
  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerImage = image.path;
      notifyListeners();
    }
  }
}
