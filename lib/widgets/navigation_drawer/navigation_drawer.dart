import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/auth_provider.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/widgets/navigation_drawer/drawer_item.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isAuthorized = authProvider.isAuthorized;
    final hasLicense = authProvider.hasLicense;

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(53, 50, 50, 1),
      ),
      child: Column(
        children: <Widget>[
          if (isAuthorized && !hasLicense) // Условие для авторизованных пользователей без лицензии
            ...[
              DrawerItem(
                'О нас',
                Icons.home,
                HomeRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
              DrawerItem(
                'Тарифы',
                Icons.shop_two,
                RatesRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
              DrawerItem(
                'Выход',
                Icons.logout,
                LogoutRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
            ],
          if (isAuthorized && hasLicense) // Условие для авторизованных пользователей с лицензией
            ...[
              DrawerItem(
                'Мой аккаунт',
                Icons.account_circle,
                ProfileRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
              DrawerItem(
                'Подключение устройств',
                Icons.device_hub,
                ConnectDevicesRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
              DrawerItem(
                'Выход',
                Icons.logout,
                LogoutRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
            ],
          if (!isAuthorized) // Условие для неавторизованных пользователей
            ...[
              DrawerItem(
                'О нас',
                Icons.home,
                HomeRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
              DrawerItem(
                'Тарифы',
                Icons.shop_two,
                RatesRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
              DrawerItem(
                'Авторизация',
                Icons.login_sharp,
                LoginRoute,
                Colors.white,
                fontFamily: 'Jura',
              ),
            ],
        ],
      ),
    );
  }
}