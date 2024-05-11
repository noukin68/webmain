import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/auth_provider.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'navbar_item.dart';
import 'navbar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isAuthorized = authProvider.isAuthorized;
    final hasLicense = authProvider.hasLicense;
    print('isAuthorized: $isAuthorized');
    print('hasLicense: $hasLicense');
    final screenWidth = MediaQuery.of(context).size.width;
    final isMediumScreen = screenWidth <= 1450 && screenWidth > 1000;
    final isSmallScreen = screenWidth <= 1000 && screenWidth > 870;
    final isExtraSmallScreen = screenWidth <= 870;

    return Container(
      height: 59,
      color: const Color.fromRGBO(53, 50, 50, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (isAuthorized && !hasLicense) // Условие для авторизованных пользователей без лицензии
                ...[
                  NavBarItem(
                    'О нас',
                    HomeRoute,
                    fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                  ),
                  SizedBox(
                    width: isExtraSmallScreen ? 60 : isSmallScreen ? 60 : isMediumScreen ? 130 : 250,
                  ),
                  NavBarItem(
                    'Тарифы',
                    RatesRoute,
                    fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                  ),
                  SizedBox(
                    width: isExtraSmallScreen ? 60 : isSmallScreen ? 60 : isMediumScreen ? 130 : 250,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: isExtraSmallScreen ? 66 : isSmallScreen ? 66 : isMediumScreen ? 86 : 106,
                    ),
                    child: NavBarItem(
                      'Выход',
                      LogoutRoute,
                      fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                    ),
                  ),
                ]
              else if (isAuthorized && hasLicense) // Условие для авторизованных пользователей с лицензией
                ...[
                  NavBarItem(
                    'Мой аккаунт',
                    ProfileRoute,
                    fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                  ),
                  SizedBox(
                    width: isExtraSmallScreen ? 60 : isSmallScreen ? 60 : isMediumScreen ? 100 : 250,
                  ),
                  NavBarItem(
                    'Подключение устройств',
                    ConnectDevicesRoute,
                    fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                  ),
                  SizedBox(
                    width: isExtraSmallScreen ? 60 : isSmallScreen ? 60 : isMediumScreen ? 100 : 250,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: isExtraSmallScreen ? 50 : isSmallScreen ? 50 : isMediumScreen ? 80 : 106,
                    ),
                    child: NavBarItem(
                      'Выход',
                      LogoutRoute,
                      fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                    ),
                  ),
                ]
              else // Условие для неавторизованных пользователей
                ...[
                  NavBarItem(
                    'О нас',
                    HomeRoute,
                    fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                  ),
                  SizedBox(
                    width: isExtraSmallScreen ? 60 : isSmallScreen ? 60 : isMediumScreen ? 130 : 250,
                  ),
                  NavBarItem(
                    'Тарифы',
                    RatesRoute,
                    fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                  ),
                  SizedBox(
                    width: isExtraSmallScreen ? 60 : isSmallScreen ? 60 : isMediumScreen ? 130 : 250,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: isExtraSmallScreen ? 50 : isSmallScreen ? 50 : isMediumScreen ? 130 : 170,
                    ),
                    child: NavBarItem(
                      'Авторизация',
                      LoginRoute,
                      fontSize: isExtraSmallScreen ? 24 : isSmallScreen ? 24 : isMediumScreen ? 28 : 32,
                    ),
                  ),
                ],
            ],
          ),
        ],
      ),
    );
  }
}