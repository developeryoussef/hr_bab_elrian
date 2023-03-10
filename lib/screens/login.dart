// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_bab_elrian/screens/slscreen.dart';
import '../controllers/auth_controller.dart';
import 'docorbi.dart';
import 'helloscreen.dart';
import 'chatspage.dart';
import 'login.dart';
import 'package:hr_bab_elrian/translation/translationCTRL.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LOGINScreen extends StatelessWidget {
  final bool? isDOCTOR;
  LOGINScreen({this.isDOCTOR});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    double width = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 27, 112, 197),
                      Color.fromARGB(255, 38, 124, 204),
                      Color.fromARGB(255, 56, 132, 172),
                      Color.fromARGB(255, 66, 137, 156)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.2, 0.5, 0.8]),
              ),
              child: SIGNIN(),
              width: width,
              height: 475,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            child: Container(
              width: width,
              height: 50,
              child: Center(
                child: Text(
                  'lgn'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 27, 112, 197),
                      Color.fromARGB(255, 38, 124, 204),
                      Color.fromARGB(255, 56, 132, 172),
                      Color.fromARGB(255, 66, 137, 156)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.2, 0.5, 0.8]),
              ),
            ),
            onPressed: () async {
              var res = await controller.signIn();

              if (res != null) {
                Get.to(ChatsS());
              }
            },
          ),
        ],
      )),
    );
  }
}

class SIGNIN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 50;

    AuthController controller = Get.put(AuthController());
    return ListView(
      children: [
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Column(
              children: [
                AuthTextFormField(
                  textEditingController: controller.signINameController,
                  hint: 'name'.tr,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (text) {
                    controller.signUpName = text;
                  },
                ),
                AuthTextFormField(
                  textEditingController: controller.signIGmailController,
                  hint: 'email'.tr,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (text) {
                    controller.signUpGmail = text;
                  },
                ),
                AuthTextFormField(
                  textEditingController: controller.signIPasswordController,
                  hint: 'password'.tr,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  onSaved: (text) {
                    controller.signUpPassword = text;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )
      ],
    );
  }
}
