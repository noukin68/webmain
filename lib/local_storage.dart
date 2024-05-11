import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  static const String _connectedUIDsKey = 'connectedUIDs';
  static const String _isAuthorizedKey = 'isAuthorized';
  static const String _hasLicenseKey = 'hasLicense';
  static const String _userIdKey = 'userId';
  static const String _emailKey = 'email';

  static Future<void> saveSessionState({
    required List<String> connectedUIDs,
    required bool isAuthorized,
    required bool hasLicense,
    required int userId,
    required String email,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_connectedUIDsKey, connectedUIDs);
    await prefs.setBool(_isAuthorizedKey, isAuthorized);
    await prefs.setBool(_hasLicenseKey, hasLicense);
    await prefs.setInt(_userIdKey, userId);
    await prefs.setString(_emailKey, email);
  }

  static Future<Map<String, dynamic>> getSessionState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? connectedUIDs = prefs.getStringList(_connectedUIDsKey);
    bool? isAuthorized = prefs.getBool(_isAuthorizedKey);
    bool? hasLicense = prefs.getBool(_hasLicenseKey);
    int? userId = prefs.getInt(_userIdKey);
    String? email = prefs.getString(_emailKey);

    return {
      'connectedUIDs': connectedUIDs ?? [],
      'isAuthorized': isAuthorized ?? false,
      'hasLicense': hasLicense ?? false,
      'userId': userId ?? 0,
      'email': email ?? '',
    };
  }
}
