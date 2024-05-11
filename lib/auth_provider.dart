import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;
import 'package:web_flutter/api_urls.dart';
import 'package:web_flutter/locator.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/services/navigation_service.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int userId = 0;

  bool _isAuthorized = false;
  bool _hasLicense = false;

  bool get isAuthorized => _isAuthorized;
  bool get hasLicense => _hasLicense;

  void updateAuthorization(bool isAuthorized, bool hasLicense) {
    print(
        'updateAuthorization: isAuthorized = $isAuthorized, hasLicense = $hasLicense');
    _isAuthorized = isAuthorized;
    _hasLicense = hasLicense;
    notifyListeners();
  }

  void updateUserId(int userId) {
    print('updateUserId: userId = $userId');
    this.userId = userId;
    notifyListeners();
  }

  Future<void> loadUserData(BuildContext context) async {
    print('loadUserData');
    try {
      final isAuthorized = _getBoolFromLocalStorage('isAuthorized');
      final hasLicense = _getBoolFromLocalStorage('hasLicense');
      final userId = _getIntFromLocalStorage('userId');

      if (isAuthorized != null && hasLicense != null && userId != null) {
        updateAuthorization(isAuthorized, hasLicense);
        updateUserId(userId);
        _navigateToRoute(context, hasLicense, userId);
      } else {
        _showErrorMessage(context, 'No user session found');
      }
    } catch (e) {
      _showErrorMessage(context, 'Error loading user data: $e');
    }
  }

  Future<void> loginUser(BuildContext context) async {
    print('loginUser');
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage(context, 'Введите email и пароль');
      return;
    }

    try {
      var requestBody = jsonEncode({
        'email': email,
        'password': password,
      });

      var response = await http.post(
        Uri.parse(ApiUrls.userLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        _isAuthorized = true;
        var responseData = json.decode(response.body);
        int userId = responseData['userId'];

        _hasLicense = await _checkLicenseStatus(context, userId);

        updateAuthorization(true, _hasLicense);
        updateUserId(userId);
        _saveUserSessionToLocalStorage(true, _hasLicense, userId);

        _navigateToRoute(context, _hasLicense, userId);

        notifyListeners();
      } else {
        _showErrorMessage(context, 'Неверный email или пароль');
      }
    } catch (e) {
      _showErrorMessage(context, 'Ошибка аутентификации: $e');
    }
  }

  void _navigateToRoute(BuildContext context, bool hasLicense, int userId) {
    print('_navigateToRoute: hasLicense = $hasLicense, userId = $userId');
    String route = hasLicense ? ProfileRoute : RatesRoute;
    locator<NavigationService>().navigateTo(route, arguments: userId);
  }

  Future<bool> _checkLicenseStatus(BuildContext context, int userId) async {
    print('_checkLicenseStatus: userId = $userId');
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
        _saveHasLicenseToLocalStorage(hasLicense);
        return hasLicense;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        _showErrorMessage(context, 'Ошибка при проверке статуса лицензии');
        return false;
      }
    } catch (e) {
      _showErrorMessage(context, 'Ошибка при проверке статуса лицензии: $e');
      return false;
    }
  }

  void clearControllers() {
    print('clearControllers');
    emailController.clear();
    passwordController.clear();
  }

  Future<void> logoutUser(BuildContext context) async {
    print('logoutUser');
    try {
      html.window.localStorage.remove('isAuthorized');
      html.window.localStorage.remove('hasLicense');
      html.window.localStorage.remove('userId');

      userId = 0;
      updateAuthorization(false, false);
      clearControllers();
      notifyListeners();
    } catch (e) {
      _showErrorMessage(context, 'Error logging out: $e');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    print('_showErrorMessage: $message');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ошибка'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool? _getBoolFromLocalStorage(String key) {
    print('_getBoolFromLocalStorage: key = $key');
    final value = html.window.localStorage[key];
    if (value != null) {
      return value == 'true';
    }
    return null;
  }

  int? _getIntFromLocalStorage(String key) {
    print('_getIntFromLocalStorage: key = $key');
    final value = html.window.localStorage[key];
    if (value != null) {
      return int.tryParse(value);
    }
    return null;
  }

  void _saveUserSessionToLocalStorage(
      bool isAuthorized, bool hasLicense, int userId) {
    print(
        '_saveUserSessionToLocalStorage: isAuthorized = $isAuthorized, hasLicense = $hasLicense, userId = $userId');
    html.window.localStorage['isAuthorized'] = isAuthorized.toString();
    html.window.localStorage['hasLicense'] = hasLicense.toString();
    html.window.localStorage['userId'] = userId.toString();
  }

  void _saveHasLicenseToLocalStorage(bool hasLicense) {
    print('_saveHasLicenseToLocalStorage: hasLicense = $hasLicense');
    html.window.localStorage['hasLicense'] = hasLicense.toString();
  }
}
