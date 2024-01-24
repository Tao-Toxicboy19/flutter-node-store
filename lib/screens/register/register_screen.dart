import 'package:flutter/material.dart';
import 'package:flutter_node_store/widgets/mobile_layout.dart';
import 'package:flutter_node_store/widgets/register_form.dart';
import 'package:flutter_node_store/widgets/responsive_layout.dart';
import 'package:flutter_node_store/widgets/tablet_layout.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      tabletChild: TabletLayout(
        imageWidget: Image.asset(
          "assets/images/signup.png",
          width: 200,
        ),
        dataWidget: RegisterForm(),
      ),
      mobildChild: MobileLayout(
        imageWidget: Image.asset(
          "assets/images/signup.png",
          width: 200,
        ),
        dataWidget: RegisterForm(),
      ),
    );
  }
}
