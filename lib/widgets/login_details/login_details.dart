import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/auth_provider.dart';
import 'package:web_flutter/locator.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/services/navigation_service.dart';
import 'package:web_flutter/utils/responsiveLayout.dart';

class LoginDetails extends StatelessWidget {
  const LoginDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFAA00FF),
            Color.fromARGB(255, 135, 90, 86),
            Color.fromARGB(255, 229, 255, 0),
          ],
        ),
      ),
      child: ResponsiveLayout(
        largeScreen: DesktopView(),
        mediumScreen: TabletView(),
        smallScreen: MobileView(),
      ),
    );
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            'Авторизация',
            style: TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jura',
            ),
          ),
          Expanded(
            child: Center(
              child: LoginCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class TabletView extends StatelessWidget {
  const TabletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Авторизация',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jura',
                ),
              ),
              Center(
                child: LoginCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Авторизация',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jura',
                ),
              ),
              Center(
                child: LoginCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMediumScreen = screenWidth <= 1450 && screenWidth > 1000;
    final isSmallScreen = screenWidth <= 1000 && screenWidth > 870;
    final isExtraSmallScreen = screenWidth <= 870;

    final double cardWidth = isExtraSmallScreen
        ? 488
        : isMediumScreen
            ? 683
            : isSmallScreen
                ? 683
                : 957;
    final double cardHeight = isExtraSmallScreen
        ? 250
        : isMediumScreen
            ? 388
            : isSmallScreen
                ? 388
                : 544;
    final double contentPadding = isExtraSmallScreen
        ? 15.0
        : isMediumScreen
            ? 21
            : isSmallScreen
                ? 21
                : 30.0;
    final double textFieldWidth = isExtraSmallScreen
        ? 284
        : isMediumScreen
            ? 398
            : isSmallScreen
                ? 398
                : 557;
    final double textFieldHeight = isExtraSmallScreen
        ? 43
        : isMediumScreen
            ? 61
            : isSmallScreen
                ? 61
                : 85;
    final double titleFontSize = isExtraSmallScreen
        ? 20
        : isMediumScreen
            ? 28
            : isSmallScreen
                ? 28
                : 40.0;
    final double subtitleFontSize = isExtraSmallScreen
        ? 16
        : isMediumScreen
            ? 23
            : isSmallScreen
                ? 23
                : 32.0;
    final double subtitleFontSizeSmall = isExtraSmallScreen
        ? 13
        : isMediumScreen
            ? 18
            : isSmallScreen
                ? 18
                : 25.0;
    final double buttonFontSize = isExtraSmallScreen
        ? 33
        : isMediumScreen
            ? 46
            : isSmallScreen
                ? 46
                : 64.0;

    return Card(
      color: Color.fromRGBO(53, 50, 50, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: EdgeInsets.all(contentPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: (isExtraSmallScreen) ? contentPadding / 2 : 0),
            Container(
              width: textFieldWidth,
              height: textFieldHeight,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: authProvider.emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontFamily: 'Jura',
                ),
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontFamily: 'Jura',
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(100, 100, 100, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: (isExtraSmallScreen) ? contentPadding / 2 : 40),
            Container(
              width: textFieldWidth,
              height: textFieldHeight,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: authProvider.passwordController,
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontFamily: 'Jura',
                ),
                decoration: InputDecoration(
                  hintText: 'Пароль',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontFamily: 'Jura',
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(100, 100, 100, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: (isExtraSmallScreen) ? contentPadding / 2 : 20),
            Text(
              'Нет аккаунта?',
              style: TextStyle(
                color: Colors.white,
                fontSize: subtitleFontSize,
                fontFamily: 'Jura',
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Зарегистрироваться',
                style: TextStyle(
                  color: Color.fromRGBO(136, 51, 166, 1),
                  fontSize: subtitleFontSizeSmall,
                  fontFamily: 'Jura',
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    locator<NavigationService>().navigateTo(RegisterRoute);
                  },
              ),
            ),
            SizedBox(height: (isExtraSmallScreen) ? contentPadding / 2 : 20),
            ElevatedButton(
              onPressed: () {
                authProvider.loginUser(context);
              },
              child: Text(
                'Войти',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: buttonFontSize,
                  fontFamily: 'Jura',
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Color.fromRGBO(216, 216, 216, 1),
                backgroundColor: Color.fromRGBO(100, 100, 100, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
            SizedBox(height: isExtraSmallScreen ? contentPadding / 2 : 0),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(53, 50, 50, 1),
      height: 59,
      width: double.infinity,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'ооо ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontFamily: 'Jura',
                ),
              ),
              TextSpan(
                text: '"ФТ-Групп"',
                style: TextStyle(
                  color: Color.fromRGBO(142, 51, 174, 1),
                  fontSize: 35,
                  fontFamily: 'Jura',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
