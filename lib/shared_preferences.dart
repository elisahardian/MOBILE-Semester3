// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesHelper {
//   static Future<void> saveUserData(String nama, String email) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userNama', nama); // Menyimpan nama pengguna
//     await prefs.setString('userEmail', email); // Menyimpan email pengguna
//   }

//   static Future<String?> getUserNama() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userNama');
//   }

//   static Future<String?> getUserEmail() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userEmail');
//   }
// }
