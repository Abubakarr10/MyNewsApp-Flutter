import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginStatus(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> getLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
