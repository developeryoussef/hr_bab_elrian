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

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.to(SLScreen());
              },
              icon: Icon(Icons.output_rounded))
        ],
        backgroundColor: Color.fromARGB(255, 39, 111, 137),
        title: Text('prof'.tr),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('${FirebaseAuth.instance.currentUser?.uid}')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children:
                snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
              var imageurl = documentSnapshot['imageurl'];
              var name = documentSnapshot['name'];
              var pn = documentSnapshot['phone number'];
              return ACCOUNTW(
                pn: pn,
                imageurl: imageurl,
                name: name,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ACCOUNTW extends StatelessWidget {
  const ACCOUNTW({
    Key? key,
    required this.imageurl,
    required this.pn,
    required this.name,
  }) : super(key: key);

  final dynamic imageurl;
  final dynamic name;
  final dynamic pn;

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());

    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 125, top: 75),
                child: IconButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection(
                          '${FirebaseAuth.instance.currentUser?.uid}');
                    },
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      color: Color.fromARGB(255, 39, 111, 137),
                      size: 37,
                    )),
              ),
              backgroundImage: NetworkImage('${imageurl}')),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ListTile(
            title: Text(
              '${name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Hey There !! I\'m here chating in Bab Elrian HR',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.person,
              size: 30,
              color: Color.fromARGB(255, 39, 111, 137),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ListTile(
            title: Text(
              'phone',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${pn}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.phone,
              size: 30,
              color: Color.fromARGB(255, 39, 111, 137),
            ),
          ),
        ),
        SizedBox(
          height: 25,
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
              height: 60,
              width: MediaQuery.of(context).size.width - 150,
            ),
            onPressed: () async {
              controller.chngeLang('ar');
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
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width - 150,
            ),
            onPressed: () async {
              controller.chngeLang('en');
            },
          ),
        ),
      ],
    );
  }
}
