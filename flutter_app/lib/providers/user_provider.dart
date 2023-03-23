import 'package:flutter/foundation.dart';

class UserIdProvider extends ChangeNotifier {
  String _userId = "";
  bool _isVolunteer = false;

  String get userId => _userId;
  bool get isVolunteer => _isVolunteer;

  void addUserId(String id) {
    _userId = id;
    print("=================== USER ID PROVIDER =================");
    print(userId);
  }

  void updateVoulnteerStatus(bool status) {
    _isVolunteer = status;
    print("=================== VOLUNTEER STATUS ==================");
    print(isVolunteer);
  }
}
