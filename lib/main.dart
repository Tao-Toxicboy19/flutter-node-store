// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import "package:flutter/material.dart";
import "package:flutter_node_store/routes/app_router.dart";
import "package:flutter_node_store/themes/styles.dart";
import "package:flutter_node_store/utils/shared_preferences.dart";

var initiaRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.initSharedPrefs();

  if (MySharedPreferences.getSharedPreference('token') != null) {
    initiaRoute = AppRouter.dashboard;
  } else if (MySharedPreferences.getSharedPreference('welcomeStatus') == true) {
    initiaRoute = AppRouter.login;
  } else {
    initiaRoute = AppRouter.welcome;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: initiaRoute,
      routes: AppRouter.routes,
    );
  }
}
