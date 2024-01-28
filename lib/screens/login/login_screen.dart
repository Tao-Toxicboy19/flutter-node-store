// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_node_store/widgets/forms/login_form.dart';
import 'package:flutter_node_store/widgets/layouts/mobile_layout.dart';
import 'package:flutter_node_store/widgets/layouts/responsive_layout.dart';
import 'package:flutter_node_store/widgets/layouts/tablet_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      tabletChild: TabletLayout(
        imageWidget: Image.asset(
          "assets/images/login.png",
          width: 200,
        ),
        dataWidget: LoginForm(),
      ),
      mobileChild: MobileLayout(
        imageWidget: Image.asset(
          "assets/images/login.png",
          width: 75,
        ),
        dataWidget: LoginForm(),
      ),
    );
  }
}
