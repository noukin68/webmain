import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_flutter/api_urls.dart';
import 'package:web_flutter/locator.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/services/navigation_service.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailVerificationCodeController =
      TextEditingController();

  bool isChecked = false;
  bool enableConfirmEmail = false;
  bool isEmailVerified = false;
  bool showVerificationCodeField = false;
  bool isResendButtonEnabled = true;
  bool isCodeSent = false;

  int userId = 0;
  int resendAttempts = 0;
  int resendCountdown = 60;

  Timer? _timer;

  void clearControllers() {
    emailController.clear();
    usernameController.clear();
    phoneController.clear();
    passwordController.clear();
    emailVerificationCodeController.clear();
  }

  Future<void> registerUser(BuildContext context) async {
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text;

    if (email.isEmpty ||
        username.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      showErrorMessage(context, 'Пожалуйста, заполните все поля');
      return;
    }

    if (!isChecked) {
      showErrorMessage(context, 'Подтвердите согласие с условиями');
      return;
    }

    RegExp phoneRegExp = RegExp(r'^\+7|8[0-9]{10}$');
    if (!phoneRegExp.hasMatch(phone)) {
      showErrorMessage(
          context, 'Пожалуйста, введите корректный номер телефона');
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(ApiUrls.checkEmailExistsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        bool emailExists = responseData['exists'];

        if (!emailExists) {
          showVerificationCodeField = true;
          notifyListeners();
          await sendEmailVerificationCode(context);
        } else {
          showErrorMessage(context, 'Этот email уже зарегистрирован');
        }
      } else {
        showErrorMessage(context, 'Ошибка проверки email');
      }
    } catch (e) {
      showErrorMessage(context, 'Ошибка проверки email: $e');
    }
  }

  Future<void> sendEmailVerificationCode(BuildContext context) async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      showErrorMessage(context, 'Пожалуйста, введите email');
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(ApiUrls.checkEmailExistsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['exists'] == true) {
          showErrorMessage(context, 'Этот email уже зарегистрирован');
          return;
        }
      } else {
        showErrorMessage(context, 'Ошибка проверки email');
        return;
      }
    } catch (e) {
      showErrorMessage(context, 'Ошибка проверки email: $e');
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(ApiUrls.sendEmailVerificationCodeUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['error'] != null) {
          showErrorMessage(context,
              'Ошибка отправки кода подтверждения: ${responseData['error']}');
        } else {
          isCodeSent = true;
          notifyListeners();
        }
      } else {
        showErrorMessage(context, 'Ошибка отправки кода подтверждения');
      }
    } catch (e) {
      showErrorMessage(context, 'Ошибка отправки кода подтверждения: $e');
    }
  }

  void startResendTimer() {
    resendCountdown = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCountdown == 0) {
        timer.cancel();
        isResendButtonEnabled = true;
        notifyListeners();
      } else {
        resendCountdown--;
        notifyListeners();
      }
    });
  }

  void stopResendTimer() {
    _timer?.cancel();
  }

  void resendEmailVerificationCode(BuildContext context) {
    if (isCodeSent) {
      sendEmailVerificationCode(context);
      isResendButtonEnabled = false;
      notifyListeners();
      startResendTimer();
    }
  }

  Future<void> finishRegisterUser(BuildContext context) async {
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text;

    try {
      var requestBody = jsonEncode({
        'email': email,
        'username': username,
        'phone': phone,
        'password': password,
      });

      var response = await http.post(
        Uri.parse(ApiUrls.userRegisterUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);

        navigateToLoginPage(context);
      } else {
        showErrorMessage(context, 'Ошибка регистрации');
      }
    } catch (e) {
      showErrorMessage(context, 'Ошибка регистрации: $e');
    }
  }

  Future<void> verifyEmail(BuildContext context) async {
    String email = emailController.text.trim();
    String verificationCode = emailVerificationCodeController.text.trim();

    print('email: ${email}');
    print('verificationCode: ${verificationCode}');

    if (email.isEmpty || verificationCode.isEmpty) {
      showErrorMessage(context,
          'Пожалуйста, введите адрес электронной почты и код подтверждения');
      return;
    }

    print('Отправка запроса на проверку кода подтверждения...');

    try {
      var response = await http.post(
        Uri.parse(ApiUrls.verifyEmailUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode({'email': email, 'verificationCode': verificationCode}),
      );

      print('Получен ответ от сервера: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['verified'] == true) {
          isEmailVerified = true;
          notifyListeners();
          await finishRegisterUser(context);
        } else {
          showErrorMessage(context, 'Неправильный код подтверждения');
        }
      } else if (response.statusCode == 400) {
        showErrorMessage(context, 'Неправильный код подтверждения');
      } else {
        showErrorMessage(context, 'Ошибка проверки кода подтверждения');
      }
    } catch (e) {
      print('Ошибка при проверке кода подтверждения: $e');
      showErrorMessage(context, 'Ошибка при проверке кода подтверждения: $e');
    }
  }

  void navigateToLoginPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Успешная регистрация'),
          content: const Text('Вы успешно зарегистрированы!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                locator<NavigationService>().navigateTo(LoginRoute);
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ошибка'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
