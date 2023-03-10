// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors_in_immutables, duplicate_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_bab_elrian/screens/empeloyee.dart';
import 'package:hr_bab_elrian/widgets/hmpageAp.dart';
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

class ChatsS extends StatelessWidget {
  const ChatsS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
              var isDoctor = documentSnapshot['docorbi'];
              return DocOrEm(isDoctor: isDoctor);
            }).toList(),
          );
        },
      ),
    );
  }
}

class DocOrEm extends StatelessWidget {
  
  const DocOrEm({
    Key? key,
    required this.isDoctor,
  }) : super(key: key);

  final dynamic isDoctor;

  @override
  Widget build(BuildContext context) {
    
    return isDoctor == true ? DoctorCs() : EmpeloyeeCs();
  }
}
