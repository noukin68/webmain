import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_flutter/api_urls.dart';

class SessionManager {
  static SharedPreferences? _prefs;
  static const _keyIsAuthorized = 'isAuthorized';
  static const _keyHasLicense = 'hasLicense';
  static const _keyUserId = 'userId';

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static bool get isAuthorized => _prefs!.getBool(_keyIsAuthorized) ?? false;
  static bool get hasLicense => _prefs!.getBool(_keyHasLicense) ?? false;
  static int get userId => _prefs!.getInt(_keyUserId) ?? 0;

  static Future<void> loginUser(String email) async {
    await _prefs!.setBool(_keyIsAuthorized, true);
    await _prefs!.setString('email', email);
  }

  static Future<void> updateUserStatus(bool hasLicense, int userId) async {
    await _prefs!.setBool(_keyHasLicense, hasLicense);
    await _prefs!.setInt(_keyUserId, userId);
  }

  static Future<void> logoutUser() async {
    await _prefs!.clear();
  }

  static Future<bool> checkLicenseStatus(int userId) async {
    try {
      var response = await http.get(
        Uri.parse('${ApiUrls.licenseStatusUrl}/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var licenseStatus = json.decode(response.body);
        bool hasLicense = licenseStatus['active'] == true;
        await _prefs!.setBool(_keyHasLicense, hasLicense);
        return hasLicense;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        throw Exception('Ошибка при проверке статуса лицензии');
      }
    } catch (e) {
      throw Exception('Ошибка при проверке статуса лицензии: $e');
    }
  }
}
