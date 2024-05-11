import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_flutter/locator.dart';
import 'package:web_flutter/services/navigation_service.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final double? fontSize;
  const NavBarItem(this.title, this.navigationPath, {this.fontSize});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          Scaffold.of(context).closeDrawer();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int? userId = prefs.getInt('userId');
          locator<NavigationService>()
              .navigateTo(navigationPath, arguments: userId);
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 35,
            fontFamily: 'Jura',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
