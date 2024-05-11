import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/auth_provider.dart';
import 'package:web_flutter/register_provider.dart';
import 'package:web_flutter/local_storage.dart';
import 'package:web_flutter/views/layout_template/layout_template.dart';
import 'package:web_flutter/widgets/connectDevices_details/connectDevices_details.dart';
import 'locator.dart';

final authProvider = AuthProvider();

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loadUserData(context);
    return MaterialApp(
      title: 'Parental Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Jura'),
      ),
      home: LayoutTemplate(),
    );
  }
}
