import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/auth_provider.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/views/connectDevices/connectDevices_view.dart';
import 'package:web_flutter/views/home/home_view.dart';
import 'package:web_flutter/views/login/login_view.dart';
import 'package:web_flutter/views/profile/profile_view.dart';
import 'package:web_flutter/views/rates/rates_view.dart';
import 'package:web_flutter/views/register/register_view.dart';
import 'package:web_flutter/views/renewRates/renewRates_view.dart';
import 'package:web_flutter/widgets/connectDevices_details/connectDevices_details.dart';

Route<dynamic> generateRoute(RouteSettings settings, BuildContext context) {
  final String? routeName = settings.name;
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final userId = authProvider.userId;

  switch (routeName) {
    case HomeRoute:
      return _getPageRoute(HomeView(userId: userId), routeName!);
    case RatesRoute:
      return _getPageRoute(RatesView(userId: userId), routeName!);
    case ConnectDevicesRoute:
      final ConnectionManager connectionManager = ConnectionManager();
      return _getPageRoute(
        ConnectDevicesView(
          userId: userId,
          connectionManager: connectionManager,
        ),
        routeName!,
      );
    case RenewRatesRoute:
      return _getPageRoute(RenewRatesView(userId: userId), routeName!);
    case LoginRoute:
      return _getPageRoute(LoginView(), routeName!);
    case RegisterRoute:
      return _getPageRoute(RegisterView(), routeName!);
    case ProfileRoute:
      if (userId == 0) {
        return _getPageRoute(LoginView(), LoginRoute);
      }
      return _getPageRoute(ProfileView(userId: userId), routeName!);
    case LogoutRoute:
       authProvider.logoutUser(context);
       return _getPageRoute(LoginView(), routeName!);
    default:
      throw ArgumentError('Unknown route: $routeName');
  }
}

PageRoute _getPageRoute(Widget child, String routeName) {
  return _FadeRoute(child: child, routeName: routeName);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({required this.child, required this.routeName})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          settings: RouteSettings(name: routeName),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
        
}