import 'package:flutter/material.dart';
import 'package:flutter_node_store/widgets/forgot_password_form.dart';
import 'package:flutter_node_store/widgets/mobile_layout.dart';
import 'package:flutter_node_store/widgets/responsive_layout.dart';
import 'package:flutter_node_store/widgets/tablet_layout.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      tabletChild: TabletLayout(
        imageWidget: Image.asset(
          "assets/images/forgot-password.png",
          width: 200,
        ),
        dataWidget:
            ForgotPasswordForm(), //Lets create widget for forgot password for & use here
      ),
      mobileChild: MobileLayout(
        imageWidget: Image.asset(
          "assets/images/forgot-password.png",
          width: 75,
        ),
        dataWidget: ForgotPasswordForm(),
      ),
    );
  }
}