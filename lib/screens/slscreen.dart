// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
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

class SLScreen extends StatelessWidget {
  final bool? isDOCTOR;
  SLScreen({this.isDOCTOR});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    double width = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
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
              child: SIGNUP(),
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
                  'sgn'.tr,
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
              var res = await controller.signUp(context);

              Get.to(ChatsS());
              
              if (controller.signUpGmailController != null || controller.signUpPasswordController != null) {
                await FirebaseFirestore.instance
                  .collection('${FirebaseAuth.instance.currentUser?.uid}')
                  .add({
                'uid': FirebaseAuth.instance.currentUser?.uid,
                'name': controller.signUpNameController!.text,
                'email': controller.signUpGmailController!.text,
                'phone number': controller.signUpPhoneController!.text,
                'imageurl': controller.imageurl,
                'docorbi': isDOCTOR,
              });
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {
                Get.to(LOGINScreen(
                  isDOCTOR: isDOCTOR,
                ));
              },
              child: Text(
                'do you'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      )),
    );
  }
}

class SIGNUP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    return ListView(
      children: [
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.add_a_photo_outlined),
              onPressed: () {
                controller.addGImage(context);
              },
            ),
          ),
        ),
        Column(
          children: [
            AuthTextFormField(
              textEditingController: controller.signUpNameController,
              hint: 'name'.tr,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              onSaved: (text) {
                controller.signUpName = text;
              },
            ),
            AuthTextFormField(
              textEditingController: controller.signUpGmailController,
              hint: 'email'.tr,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              onSaved: (text) {
                controller.signUpGmail = text;
              },
            ),
            AuthTextFormField(
              textEditingController: controller.signUpPasswordController,
              hint: 'password'.tr,
              obscureText: true,
              keyboardType: TextInputType.text,
              onSaved: (text) {
                controller.signUpPassword = text;
              },
            ),
            AuthTextFormField(
              textEditingController: controller.signUpPhoneController,
              hint: 'phone'.tr,
              obscureText: false,
              keyboardType: TextInputType.number,
              onSaved: (text) {
                controller.signUpPhone = text;
              },
            ),
            AuthTextFormField(
              onSaved: (p0) {
                
              },
              textEditingController: controller.signUpSpecController,
              hint: 'spec'.tr,
              obscureText: false,
              keyboardType: TextInputType.number,
              
            ),
            AuthTextFormField(
              textEditingController: controller.signUpIDNController,
              hint: 'idn'.tr,
              obscureText: false,
              keyboardType: TextInputType.number,
              onSaved: (text) {
                controller.signUpIDNumber = text;
              },
            ),
          ],
        )
      ],
    );
  }
}

class AuthTextFormField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? hint;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  const AuthTextFormField({
    required this.textEditingController,
    required this.hint,
    required this.obscureText,
    required this.keyboardType,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 25,
          ),
          child: Container(
            height: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2)),
              ],
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'the field is empty';
                }
              },
              onSaved: onSaved,
              controller: textEditingController,
              obscureText: obscureText!,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    height: 1,
                  )),
            ),
          ),
        );
      },
    );
  }
}
