// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_bab_elrian/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalController extends GetxController {
  Locale initLang = sharedPreferences!.getString("lang") == 'ar'
      ? Locale('ar')
      : Locale("en");

  void chngeLang(String name) {
    Locale local = Locale(name);
    sharedPreferences!.setString("lang", name);
    Get.updateLocale(local);
  }
}
