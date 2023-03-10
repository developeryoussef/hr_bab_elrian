// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  var signinName;
  TextEditingController? signINameController = TextEditingController();
  var signinGmail;
  TextEditingController? signIGmailController = TextEditingController();

  var signinPassword;
  TextEditingController? signIPasswordController = TextEditingController();

  var signUpName;
  TextEditingController? signUpNameController = TextEditingController();

  var signUpGmail;
  TextEditingController? signUpGmailController = TextEditingController();

  var signUpPassword;
  TextEditingController? signUpPasswordController = TextEditingController();

  var signUpPhone;
  TextEditingController? signUpPhoneController = TextEditingController();
  TextEditingController? signUpSpecController = TextEditingController();

  var signUpIDNumber;
  TextEditingController? signUpIDNController = TextEditingController();

  File? file;
  var imageurl;

  addGImage(BuildContext context) async {
    var imageP = await ImagePicker();
    var picked = await imageP.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      file = File(picked.path);

      var random = Random().nextInt(1000000);

      var imagename = '$random' + path.basename(picked.path);
      Reference ref =
          await FirebaseStorage.instance.ref('images').child(imagename);
      await ref.putFile(file!);
      imageurl = await ref.getDownloadURL();
    }
  }

  Future<UserCredential?> signUp(BuildContext context) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpGmailController!.text.trim(),
        password: signUpPasswordController!.text.trim(),
      );
      addGImage(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {}
  }

  Future<UserCredential?> signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signIGmailController!.text,
        password: signIPasswordController!.text,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
