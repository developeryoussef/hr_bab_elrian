// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last

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

class DOCORBI extends StatelessWidget {
  const DOCORBI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Image.network(
                    'https://scontent.xx.fbcdn.net/v/t1.15752-9/333406371_5929157753834123_1576795792319023917_n.jpg?stp=dst-jpg_p403x403&_nc_cat=111&ccb=1-7&_nc_sid=aee45a&_nc_ohc=HPDDDoe9Q1UAX-EJgRd&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdQfE1yxMn85bGu5gPTJeAwpGWnbQHgDg6SElQtoFhX7Jw&oe=642B999E'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: MaterialButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      'docorbi1'.tr,
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
                        topRight: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                        bottomLeft: Radius.circular(35),
                        topLeft: Radius.circular(35)),
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width - 80,
                ),
                onPressed: () async {
                  Get.to(SLScreen(isDOCTOR: true));
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: MaterialButton(
                child: Container(
                  child: Center(
                    child: Text(
                      'docorbi2'.tr,
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
                        topRight: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                        bottomLeft: Radius.circular(35),
                        topLeft: Radius.circular(35)),
                  ),
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width - 80,
                ),
                onPressed: () async {
                  Get.to(SLScreen(isDOCTOR: false));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
