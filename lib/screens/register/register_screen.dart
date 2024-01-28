import 'package:flutter/material.dart';
import 'package:flutter_node_store/widgets/layouts/mobile_layout.dart';
import 'package:flutter_node_store/widgets/forms/register_form.dart';
import 'package:flutter_node_store/widgets/layouts/responsive_layout.dart';
import 'package:flutter_node_store/widgets/layouts/tablet_layout.dart';

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
      mobileChild: MobileLayout(
        imageWidget: Image.asset(
          "assets/images/signup.png",
          width: 200,
        ),
        dataWidget: RegisterForm(),
      ),
    );
  }
}
