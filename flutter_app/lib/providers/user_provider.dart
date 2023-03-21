import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String? userId;
  String? name;
  String? mobileNumber;
  String? gender;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? qualification;
  String? organization;
  final skills = <String>[];
  final languages = <String>[];

  bool isVolunteer = false;
  bool basicDetailsFilled = false;

  UserModel();

  UserModel.addingBasicDetails(this.userId, this.name, this.mobileNumber, this.gender,
      this.country, this.state, this.city, this.pincode) {
    notifyListeners();
  }
}
