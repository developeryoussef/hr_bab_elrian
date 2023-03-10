// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportsController extends GetxController {
  TextEditingController? doctorName = TextEditingController();
  TextEditingController? doctorSpecialty = TextEditingController();
  TextEditingController? doctorAddres = TextEditingController();
  TextEditingController? doctorVisitResult = TextEditingController();
  TextEditingController? doctorPhoneNumber = TextEditingController();
}
