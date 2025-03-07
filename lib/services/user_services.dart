import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _userKey = 'user_data';

  Future<bool> isNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    return !prefs.containsKey(_userKey);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }
}
