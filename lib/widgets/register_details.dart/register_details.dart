import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/register_provider.dart';
import 'package:web_flutter/utils/responsiveLayout.dart';

class RegisterDetails extends StatelessWidget {
  const RegisterDetails({Key? key}) : super(key: key);

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Регистрация',
            style: TextStyle(
              color: Colors.white,
              fontSize: 96,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jura',
            ),
          ),
          RegisterCard(),
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
      child: Column(
        children: [
          Text(
            'Регистрация',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jura',
            ),
          ),
          RegisterCard(),
        ],
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Регистрация',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jura',
            ),
          ),
          RegisterCard(),
        ],
      ),
    );
  }
}

class RegisterCard extends StatefulWidget {
  const RegisterCard({Key? key}) : super(key: key);

  @override
  _RegisterCardState createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = ResponsiveLayout.isSmallScreen(context);
        final isMedium = ResponsiveLayout.isMediumScreen(context);
        final double cardWidth = 957;
        final double cardHeight = 612;
        final double contentPadding = 30.0;
        final double textFieldWidth = 557;
        final double textFieldHeight = 82;
        final double buttonMinWidth = 302;
        final double buttonMinHeight = 74;
        final double titleFontSize = 35.0;
        final double subtitleFontSize = 20.0;
        final double buttonFontSize = 60.0;
        final double subtitleFontSizeSmall = 25.0;

        return Card(
          color: Color.fromRGBO(53, 50, 50, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            width: isMobile || isMedium ? 857 : cardWidth,
            height: isMobile || isMedium ? null : cardHeight,
            padding: EdgeInsets.all(contentPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: (isMobile) ? contentPadding / 2 : 0),
                registerProvider.showVerificationCodeField
                    ? Column(
                        children: [
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          Text(
                            'На ${registerProvider.emailController.text} было выслано письмо с кодом подтверждения',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Jura',
                            ),
                          ),
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          Container(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: TextFormField(
                              controller: registerProvider
                                  .emailVerificationCodeController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile
                                    ? titleFontSize * 0.5
                                    : isMedium
                                        ? titleFontSize * 0.6
                                        : titleFontSize,
                                fontFamily: 'Jura',
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Код подтверждения',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(216, 216, 216, 1),
                                  fontSize: isMobile
                                      ? titleFontSize * 0.5
                                      : isMedium
                                          ? titleFontSize * 0.6
                                          : titleFontSize,
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
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          ElevatedButton(
                            onPressed: () =>
                                registerProvider.verifyEmail(context),
                            child: Text(
                              'Отправить',
                              style: TextStyle(
                                fontSize: isMobile
                                    ? buttonFontSize * 0.6
                                    : isMedium
                                        ? buttonFontSize * 0.75
                                        : buttonFontSize,
                                fontFamily: 'Jura',
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Color.fromRGBO(216, 216, 216, 1),
                              backgroundColor: Color.fromRGBO(100, 100, 100, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              minimumSize: Size(
                                buttonMinWidth,
                                isMobile
                                    ? textFieldHeight * 0.6
                                    : isMedium
                                        ? textFieldHeight * 0.7
                                        : buttonMinHeight,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              registerProvider.isResendButtonEnabled
                                  ? GestureDetector(
                                      onTap: () {
                                        registerProvider
                                            .resendEmailVerificationCode(
                                                context);
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Text(
                                          'Отправить повторно',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(136, 51, 166, 1),
                                            fontSize: isMobile
                                                ? subtitleFontSizeSmall * 0.8
                                                : isMedium
                                                    ? subtitleFontSizeSmall *
                                                        0.8
                                                    : subtitleFontSizeSmall,
                                            fontFamily: 'Jura',
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Повторная отправка через ${registerProvider.resendCountdown} сек',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          SizedBox(height: (isMobile) ? contentPadding / 2 : 0),
                          Container(
                            width: textFieldWidth,
                            height: isMobile
                                ? textFieldHeight * 0.6
                                : isMedium
                                    ? textFieldHeight * 0.7
                                    : textFieldHeight,
                            child: TextFormField(
                              controller: registerProvider.usernameController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile
                                    ? titleFontSize * 0.5
                                    : isMedium
                                        ? titleFontSize * 0.6
                                        : titleFontSize,
                                fontFamily: 'Jura',
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Имя',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(216, 216, 216, 1),
                                  fontSize: isMobile
                                      ? titleFontSize * 0.5
                                      : isMedium
                                          ? titleFontSize * 0.6
                                          : titleFontSize,
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
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: textFieldWidth,
                                height: isMobile
                                    ? textFieldHeight * 0.6
                                    : isMedium
                                        ? textFieldHeight * 0.7
                                        : textFieldHeight,
                                child: TextFormField(
                                  controller: registerProvider.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile
                                        ? titleFontSize * 0.5
                                        : isMedium
                                            ? titleFontSize * 0.6
                                            : titleFontSize,
                                    fontFamily: 'Jura',
                                  ),
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: 'E-mail',
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(216, 216, 216, 1),
                                      fontSize: isMobile
                                          ? titleFontSize * 0.5
                                          : isMedium
                                              ? titleFontSize * 0.6
                                              : titleFontSize,
                                      fontFamily: 'Jura',
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(100, 100, 100, 1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    registerProvider.enableConfirmEmail =
                                        value.isNotEmpty;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          Container(
                            width: textFieldWidth,
                            height: isMobile
                                ? textFieldHeight * 0.6
                                : isMedium
                                    ? textFieldHeight * 0.7
                                    : textFieldHeight,
                            child: TextFormField(
                              controller: registerProvider.phoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile
                                    ? titleFontSize * 0.5
                                    : isMedium
                                        ? titleFontSize * 0.6
                                        : titleFontSize,
                                fontFamily: 'Jura',
                              ),
                              cursorColor: Colors.white,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  if (!value.startsWith('+7') &&
                                      !value.startsWith('8')) {
                                    registerProvider.phoneController.text =
                                        '+7';
                                    registerProvider.phoneController.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                          offset: registerProvider
                                              .phoneController.text.length),
                                    );
                                  }

                                  String digits =
                                      value.replaceAll(RegExp(r'\D'), '');

                                  if (digits.length >= 1) {
                                    String formattedPhone = '+7';

                                    if (digits.length >= 2) {
                                      formattedPhone +=
                                          ' (' + digits.substring(1, 4);
                                    }

                                    if (digits.length >= 5) {
                                      formattedPhone +=
                                          ') ' + digits.substring(4, 7);
                                    }

                                    if (digits.length >= 8) {
                                      formattedPhone +=
                                          '-' + digits.substring(7, 9);
                                    }

                                    if (digits.length >= 10) {
                                      formattedPhone +=
                                          '-' + digits.substring(9, 11);
                                    }

                                    registerProvider.phoneController.value =
                                        registerProvider.phoneController.value
                                            .copyWith(
                                      text: formattedPhone,
                                      selection: TextSelection.collapsed(
                                          offset: formattedPhone.length),
                                    );
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Номер телефона',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(216, 216, 216, 1),
                                  fontSize: isMobile
                                      ? titleFontSize * 0.5
                                      : isMedium
                                          ? titleFontSize * 0.6
                                          : titleFontSize,
                                  fontFamily: 'Jura',
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(100, 100, 100, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                RegExp phoneRegExp = RegExp(
                                    r'^\+7 $$\d{3}$$ \d{3}-\d{2}-\d{2}$');
                                if (!phoneRegExp.hasMatch(value!)) {
                                  return 'Введите корректный номер телефона';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          Container(
                            width: textFieldWidth,
                            height: isMobile
                                ? textFieldHeight * 0.6
                                : isMedium
                                    ? textFieldHeight * 0.7
                                    : textFieldHeight,
                            child: TextFormField(
                              controller: registerProvider.passwordController,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile
                                    ? titleFontSize * 0.5
                                    : isMedium
                                        ? titleFontSize * 0.6
                                        : titleFontSize,
                                fontFamily: 'Jura',
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Пароль',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(216, 216, 216, 1),
                                  fontSize: isMobile
                                      ? titleFontSize * 0.5
                                      : isMedium
                                          ? titleFontSize * 0.6
                                          : titleFontSize,
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
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Checkbox(
                                    value: registerProvider.isChecked,
                                    onChanged: (bool? newValue) {
                                      registerProvider.isChecked = newValue!;
                                      setState(() {});
                                    },
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Я согласен с ',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                216, 216, 216, 1),
                                            fontSize: isMobile
                                                ? subtitleFontSize * 0.6
                                                : isMedium
                                                    ? subtitleFontSize * 0.8
                                                    : subtitleFontSize,
                                            fontFamily: 'Jura',
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'лицензионным соглашением',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(192, 8, 196, 1),
                                            fontSize: isMobile
                                                ? subtitleFontSize * 0.6
                                                : isMedium
                                                    ? subtitleFontSize * 0.8
                                                    : subtitleFontSize,
                                            fontFamily: 'Jura',
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: (isMobile) ? contentPadding / 2 : 20),
                          ElevatedButton(
                            onPressed: () {
                              registerProvider.registerUser(context);
                              setState(() {});
                            },
                            child: Text(
                              'Войти',
                              style: TextStyle(
                                fontSize: isMobile
                                    ? buttonFontSize * 0.6
                                    : isMedium
                                        ? buttonFontSize * 0.75
                                        : buttonFontSize,
                                fontFamily: 'Jura',
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Color.fromRGBO(216, 216, 216, 1),
                              backgroundColor: Color.fromRGBO(100, 100, 100, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              minimumSize: Size(
                                buttonMinWidth,
                                isMobile
                                    ? textFieldHeight * 0.6
                                    : isMedium
                                        ? textFieldHeight * 0.7
                                        : buttonMinHeight,
                              ),
                            ),
                          ),
                          SizedBox(height: (isMobile) ? contentPadding / 2 : 0),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
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
