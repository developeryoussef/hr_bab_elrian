// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_bab_elrian/controllers/reportscontroller.dart';
import 'package:hr_bab_elrian/screens/empeloyee.dart';
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

class ReportsS extends StatelessWidget {
  const ReportsS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
          child: GetBuilder<ReportsController>(
        init: ReportsController(),
        builder: (controller) {
          return Column(
            children: [
              Bar(

              ),
              MaterialButton(
            child: Container(
              width: 400,
              height: 50,
              child: Center(
                child: Text(
                  'reports',
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

              Get.to(Trep());
              
              
              
            },),
              REPORTSTextField(
                controller: controller.doctorName,
                hintText: 'doctor name',
                maxlines: 1,
              ),
              REPORTSTextField(
                controller: controller.doctorAddres,
                hintText: 'doctor addres',
                maxlines: 2,
              ),
              REPORTSTextField(
                controller: controller.doctorSpecialty,
                hintText: 'doctor specialty',
                maxlines: 1,
              ),
              REPORTSTextField(
                controller: controller.doctorVisitResult,
                hintText: 'Visit Reason',
                maxlines: 100,
              ),
              REPORTSTextField(
                controller: controller.doctorPhoneNumber,
                hintText: 'doctor phone number',
                maxlines: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: MaterialButton(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Send Report',
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
                    var fireref =
                        FirebaseFirestore.instance.collection('reports');

                    await fireref
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('reports')
                        .add({
                      'doctor name': controller.doctorName!.text,
                      'doctor specialty': controller.doctorSpecialty!.text,
                      'doctor addres': controller.doctorAddres!.text,
                      'visit reason': controller.doctorVisitResult!.text,
                      'doctor phone number': controller.doctorPhoneNumber!.text,
                    });
                  
                    print(controller.doctorAddres!.text);
                  },
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}

class REPORTSTextField extends StatelessWidget {
  final String? hintText;
  final int? maxlines;
  final TextEditingController? controller;
  REPORTSTextField(
      {required this.hintText,
      required this.maxlines,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    height: 1,
                  )),
            minLines: 1,
            maxLines: maxlines,
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 7),
            ]),
      ),
    );
  }
}

class Trep extends StatelessWidget {
  const Trep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('rep'.tr),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('reports').doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('reports').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasData){
          return Container(
            child: ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot documentSnapshot) {
                                return Material(
                                  color: Colors.blueGrey,
                                  child: Padding(
                                    child: Column(
                                      children: [
                                        ListTile(
                                         title: Text('doctor name: ${documentSnapshot['doctor name']}' , style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                         ),), 
                                        ),
                                        ListTile(
                                         title: Text('doctor specialty: ${documentSnapshot['doctor specialty']}' , style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                         ),), 
                                        ),
                                        ListTile(
                                         title: Text('doctor addres" ${documentSnapshot['doctor addres']}' , style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                         ),), 
                                        ),
                                        ListTile(
                                         title: Text('visitreason: ${documentSnapshot['visit reason']}' , style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                         ),), 
                                        ),
                                         ListTile(
                                         title: Text('phone: ${documentSnapshot['doctor phone number']}' , style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                         ),), 
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(30)),
                                );

                              }).toList(),
                            ),
                            
          );
          
          }
          return Center(
            child: Text('There isn\'t any reports'),
          );
      },),
    );
  }
}
