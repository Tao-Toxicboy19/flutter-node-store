// ignore_for_file: prefer_const_constructors

import 'package:flutter_node_store/screens/login/login_screen.dart';
import 'package:flutter_node_store/screens/welcome/welcome_screen.dart';

class AppRouter {
  // Router map keys

  static const String welcome = "welcome";
  static const String login = "login";

  static get routes => {
        welcome: (context) => WelcomeScreen(),
        login: (context) => LoginScreen(),
      };
}
