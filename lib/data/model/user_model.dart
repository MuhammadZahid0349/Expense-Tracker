// Import required packages
import 'package:hive/hive.dart';

// User data model class
class UserData {
  String name;
  String email;
  String age;
  String currentDate;
  String currentTime;

  UserData({
    required this.name,
    required this.email,
    required this.age,
    required this.currentDate,
    required this.currentTime,
  });
}
