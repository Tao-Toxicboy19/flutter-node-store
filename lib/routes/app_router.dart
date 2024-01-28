// ignore_for_file: prefer_const_constructors

import 'package:flutter_node_store/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_node_store/screens/drawer/about_screen.dart';
import 'package:flutter_node_store/screens/drawer/contact_screen.dart';
import 'package:flutter_node_store/screens/drawer/info_screen.dart';
import 'package:flutter_node_store/screens/forgotpassword/forgot_password_screen.dart';
import 'package:flutter_node_store/screens/login/login_screen.dart';
import 'package:flutter_node_store/screens/register/register_screen.dart';
import 'package:flutter_node_store/screens/welcome/welcome_screen.dart';

class AppRouter {
  // Router map keys

  static const String welcome = "welcome";
  static const String login = "login";
  static const String register = "register";
  static const String forgotPassword = " forgotPassword";
  static const String dashboard = "dashboard";
  static const String info = "info";
  static const String contact = "contact";
  static const String about = "about";

  static get routes => {
        welcome: (context) => WelcomeScreen(),
        login: (context) => LoginScreen(),
        register: (context) => RegisterScreen(),
        forgotPassword: (context) => ForgotPasswordScreen(),
        dashboard: (context) => DashboardScreen(),
        info: (context) => InfoScreen(),
        contact: (context) => ContactScreen(),
        about: (context) => AboutScreen(),
      };
}
