// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_node_store/widgets/login_form.dart';
import 'package:flutter_node_store/widgets/mobile_layout.dart';
import 'package:flutter_node_store/widgets/responsive_layout.dart';
import 'package:flutter_node_store/widgets/tablet_layout.dart';

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
      mobildChild: MobileLayout(
        imageWidget: Image.asset(
          "assets/images/login.png",
          width: 75,
        ),
        dataWidget: LoginForm(),
      ),
    );
  }
}
