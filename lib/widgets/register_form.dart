// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_node_store/routes/app_router.dart';
import 'package:flutter_node_store/services/api_service.dart';
import 'package:flutter_node_store/utils/utility.dart';
import 'package:flutter_node_store/widgets/share/custom_textfield.dart';
import 'package:flutter_node_store/widgets/share/rounded_button.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  // สร้าง GlobalKey สำหรับ Form นี้
  final _formKeyRegister = GlobalKey<FormState>();

  // สร้าง TextEditingController
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "ลงทะเบียน",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKeyRegister,
            child: Column(
              children: [
                customTextField(
                  controller: _firstNameController,
                  hintText: "First Name",
                  prefixIcon: const Icon(Icons.person),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกชื่อ";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: _lastNameController,
                  hintText: "Last Name",
                  prefixIcon: const Icon(Icons.person),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกนามสกุล";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: _emailController,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  obscureText: false,
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
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกรหัสผ่าน";
                    } else if (value.length < 6) {
                      return "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกรหัสผ่านอีกครั้ง";
                    } else if (value != _passwordController.text) {
                      return "กรุณากรอกรหัสผ่านให้ตรงกัน";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  label: "SIGN UP",
                  onPressed: () async {
                    // ตรวจสอบข้อมูลฟอร์ม
                    if (_formKeyRegister.currentState!.validate()) {
                      // ถ้าข้อมูลถูกต้อง ให้ทำการบันทึกข้อมูล
                      _formKeyRegister.currentState!.save();
                      var response = jsonDecode(
                        await ApiService().registerLocal(
                          {
                            "firstname": _firstNameController.text,
                            "lastname": _lastNameController.text,
                            "email": _emailController.text,
                            "password": _passwordController.text
                          },
                        ),
                      );
                      if (response["success"] == 'No network is Connected') {
                        Utility.showAlertDialog(
                          context,
                          "แจ้งเตือน",
                          response["message"],
                        );
                      } else {
                        if (response['status'] == 'ok') {
                          Navigator.pushReplacementNamed(
                              context, AppRouter.login);
                        } else {
                          Utility.showAlertDialog(
                            context,
                            'แจ้งเตือน',
                            response['message'],
                          );
                          Utility.showAlertDialog(
                            context,
                            'แจ้งเตือน',
                            response['message'],
                          );
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("มีบัญชีอยู่แล้ว ? "),
              InkWell(
                onTap: () {
                  //Open Login screen here
                  Navigator.pushReplacementNamed(context, AppRouter.login);
                },
                child: const Text(
                  "เข้าสู่ระบบ",
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
