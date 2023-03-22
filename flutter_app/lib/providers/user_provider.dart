import 'package:flutter/foundation.dart';

class UserIdProvider extends ChangeNotifier {
//   String? userId;
//   String? name;
//   String? mobileNumber;
//   String? gender;
//   String? country;
//   String? state;
//   String? city;
//   String? pincode;
//   String? qualification;
//   String? organization;
//   final skills = <String>[];
//   final languages = <String>[];

//   bool isVolunteer = false;
//   bool basicDetailsFilled = false;

//   final user = {};

//   void addingBasicDetails(
//       userId, name, mobileNumber, gender, country, state, city, pincode) {
//     this.userId = userId;
//     this.name = name;
//     this.mobileNumber = mobileNumber;
//     this.gender = gender;
//     this.country = country;
//     this.state = state;
//     this.city = city;
//     this.pincode = pincode;
//     user['userId'] = userId;
//     user['name'] = name;
//     user['mobile_number'] = mobileNumber;
//     user['gender'] = gender;
//     user['country'] = country;
//     user['state'] = state;
//     user['city'] = city;
//     user['pincode'] = pincode;
//     notifyListeners();
//   }
// }

  String _userId = "";

  String get userId => _userId;

  void addUserId(String id) {
    _userId = id;
    print("=================== USER ID PROVIDER =================");
    print(userId);
  }
}
