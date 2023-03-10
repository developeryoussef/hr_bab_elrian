// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last

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

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Image.asset('asset/logo.jpg'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: MaterialButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      'اللغة العربية',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 20, 106, 192),
                          Color.fromARGB(255, 30, 120, 203),
                          Color.fromARGB(255, 50, 127, 167),
                          Color.fromARGB(255, 39, 111, 137)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, 0.2, 0.5, 0.8]),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)),
                  ),
                  height: 70,
                  width: MediaQuery.of(context).size.width - 100,
                ),
                onPressed: () async {
                  controller.chngeLang('ar');
                  Get.to(DOCORBI());
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: MaterialButton(
                child: Container(
                  child: Center(
                    child: Text(
                      'English',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 20, 106, 192),
                          Color.fromARGB(255, 30, 120, 203),
                          Color.fromARGB(255, 50, 127, 167),
                          Color.fromARGB(255, 39, 111, 137)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, 0.2, 0.5, 0.8]),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                  ),
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width - 100,
                ),
                onPressed: () async {
                  controller.chngeLang('en');
                  Get.to(DOCORBI());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
