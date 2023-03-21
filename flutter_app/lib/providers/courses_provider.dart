import 'package:flutter/foundation.dart';

class CourseProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> courses = [];
  final List<Map<String, dynamic>> course_names = [];

  void addCourses(course) {
    courses.add(course);
    notifyListeners();
  }
}
