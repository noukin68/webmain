import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_flutter/locator.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/routing/router.dart';
import 'package:web_flutter/services/navigation_service.dart';
import 'package:web_flutter/widgets/navigation_bar/navigation_bar.dart';
import 'package:web_flutter/widgets/navigation_drawer/navigation_drawer.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = locator<NavigationService>().navigatorKey.currentState!;
        if (navigator.canPop()) {
          locator<NavigationService>().goBack();
          return false;
        }
        return true;
      },
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? MyNavigationDrawer()
              : null,
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MyNavigationBar(),
              Expanded(
                child: Navigator(
                  key: locator<NavigationService>().navigatorKey,
                  onGenerateRoute: (settings) => generateRoute(settings, context),
                  initialRoute: HomeRoute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
