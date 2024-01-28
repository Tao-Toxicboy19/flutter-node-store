// ignore_for_file: unused_field, must_be_immutable, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_node_store/routes/app_router.dart';
import 'package:flutter_node_store/services/api_service.dart';
import 'package:flutter_node_store/utils/shared_preferences.dart';
import 'package:flutter_node_store/widgets/share/alert_dialog.dart';
import 'package:flutter_node_store/widgets/share/custom_textfield.dart';
import 'package:flutter_node_store/widgets/share/rounded_button.dart';
import 'package:flutter_node_store/widgets/social_media_option.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  // สร้าง GlobalKey สำหรับ Form นี้
  final _formKeyLogin = GlobalKey<FormState>();

  // สร้าง TextEditingController
  final _emailController = TextEditingController(text: "test@");
  final _passwordController = TextEditingController(text: "test12");

  final ApiService _apiService = ApiService();
  final AlertDialogManager _alertDialogManager = AlertDialogManager();

  Future<void> _handleSubmit(BuildContext context) async {
    if (_formKeyLogin.currentState!.validate()) {
      _formKeyLogin.currentState!.save();

      var values = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      var res = await _apiService.loginLocal(values);
      var result = jsonDecode(res);
      if (result['massage'] == 'No network is Connected') {
        _alertDialogManager.showAlertDialog(
          context,
          "แจ้งเตือน",
          result["message"],
        );
      } else {
        if (result['status'] == 'ok') {
          await MySharedPreferences.setSharedPreference(
              'token', result['token']);
          await MySharedPreferences.setSharedPreference('user', result['user']);
          Navigator.pushReplacementNamed(context, AppRouter.dashboard);
        } else {
          _alertDialogManager.showAlertDialog(
            context,
            result['status'],
            result["message"],
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "เข้าสู่ระบบ",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                customTextField(
                  controller: _emailController,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกอีเมล";
                    } else if (!value.contains("@")) {
                      return "กรุณากรอกอีเมลให้ถูกต้อง";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "กรุณากรอกรหัสผ่าน";
                      } else if (value.length < 6) {
                        return "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        //Open Forgot password screen here
                        Navigator.pushNamed(context, AppRouter.forgotPassword);
                      },
                      child: const Text("ลืมรหัสผ่าน ?"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  label: "LOGIN",
                  onPressed: () => _handleSubmit(context),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SocialMediaOptions(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ยังไม่มีบัญชีกับเรา ? "),
              InkWell(
                onTap: () {
                  //Open Sign up screen here
                  Navigator.pushReplacementNamed(context, AppRouter.register);
                },
                child: const Text(
                  "สมัครสมาชิก",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
