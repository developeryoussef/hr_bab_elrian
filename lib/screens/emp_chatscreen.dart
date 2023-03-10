// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'dart:io';
import 'dart:math';

import 'package:hr_bab_elrian/screens/chatspage.dart';

import 'chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../controllers/chat_controller.dart';

class EchatScreen extends StatelessWidget {
  final String? did;
  final String? imageurl;
  final String? gname;

  const EchatScreen({this.did, this.imageurl, required this.gname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatController>(
        builder: (controller) {
          return Container(
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
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                EChatAppBar(
                  gname: gname,
                  imageurl: imageurl,
                ),
                EMessagesPart(did: did),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                Expanded(
                  flex: 5,
                  child: EChatTextField(
                    did: did,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        },
        init: ChatController(),
      ),
    );
  }
}

class EChatTextField extends StatefulWidget {
  final dynamic? did;
  EChatTextField({required this.did});

  @override
  State<EChatTextField> createState() => _EChatTextFieldState();
}

class _EChatTextFieldState extends State<EChatTextField> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Row(
          children: [
            Container(
              width: width - 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromARGB(255, 246, 247, 255),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 14,
                      color: Colors.black.withOpacity(0.7),
                    )
                  ]),
              padding: EdgeInsets.only(left: 28, bottom: 8, right: 28),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'message',
                        ),
                        
                        minLines: 1,
                        maxLines: 100,
                        onChanged: (message) {
                          controller.message = message;
                        },
                        controller: controller.controller,
                        
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () async {
                            var random = Random().nextInt(100000000);

                            var imageP = await ImagePicker();
                            var picked = await imageP.pickImage(
                                source: ImageSource.gallery);

                            if (picked != null) {
                              controller.file = File(picked.path);

                              var imagename = p.basename(picked.path);
                              imagename = '$random$imagename';
                              Reference ref = await FirebaseStorage.instance
                                  .ref('images')
                                  .child(imagename);
                              await ref.putFile(controller.file!);
                              controller.imageURL = await ref.getDownloadURL();
                              await FirebaseFirestore.instance
                                  .collection('empeloyees')
                                  .doc(widget.did)
                                  .collection('messages')
                                  .add({
                                'imageUrl': controller.imageURL,
                                'type': 'image',
                                'sender':
                                    FirebaseAuth.instance.currentUser!.email,
                                'time': FieldValue.serverTimestamp(),
                              });
                            }
                          },
                          icon: Icon(Icons.image)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Center(
              child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 246, 247, 255),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 33,
                    shadows: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.black.withOpacity(0.4))
                    ],
                  ),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('empeloyees')
                        .doc(widget.did)
                        .collection('messages')
                        .add({
                      'message': controller.message,
                      'sender': FirebaseAuth.instance.currentUser!.email,
                      'time': FieldValue.serverTimestamp(),
                      'type': 'text',
                    });
                    controller.clearMessage();
                  }),
            ),
          ],
        );
      },
    );
  }
}

class EChatAppBar extends StatelessWidget {
  final String? imageurl;
  final String? gname;

  EChatAppBar({required this.imageurl, required this.gname});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Expanded(
          flex: 5,
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Get.to(ChatsS());
                      },
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.addGImage(context);
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage('${imageurl}'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${gname}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

var currentUser = FirebaseAuth.instance.currentUser!.email;

class EMessagesPart extends StatelessWidget {
  final String? did;
  EMessagesPart({required this.did});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Expanded(
          flex: 35,
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('empeloyees')
                  .doc(did)
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return ListView(
                    reverse: true,
                    children: snapshot.data!.docs.reversed
                        .map((DocumentSnapshot document) {
                      return EMessageLine(
                        docid: document.id,
                        data: document.data()! as Map<String, dynamic>,
                      );
                    }).toList(),
                  );
                }
                return Text(
                  'Hello',
                  style: TextStyle(color: Colors.white),
                );
              },
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
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: NetworkImage(
              //         'https://w0.peakpx.com/wallpaper/508/606/HD-wallpaper-whatsapp-l-background-doodle-pattern-patterns.jpg'))
            ),
          ),
        );
      },
    );
  }
}

class EMessageLine extends StatelessWidget {
  final dynamic data;
  final dynamic docid;
  EMessageLine({required this.data, required this.docid});

  CollectionReference notesref =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: data['type'] == 'image'
          ? EImageMessage(data: data, docid: docid)
          : ETextMessage(data: data, docid: docid),
    );
  }
}

class EImageMessage extends StatelessWidget {
  final dynamic data;
  final dynamic docid;
  EImageMessage({required this.data, required this.docid});

  CollectionReference notesref =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: currentUser == data['sender']
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: currentUser == data['sender'] ? 30 : 15,
                  bottom: 7,
                  top: 7,
                  right: currentUser != data['sender'] ? 40 : 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: currentUser != data['sender']
                  ? Text(
                      "${data['sender']}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 143, 125),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      'Me',
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 143, 125),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  topLeft: currentUser == data['sender']
                      ? Radius.circular(25)
                      : Radius.circular(25),
                  topRight: currentUser != data['sender']
                      ? Radius.circular(25)
                      : Radius.circular(25),
                ),
              ),
              child: Container(
                height: 400,
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    topLeft: currentUser == data['sender']
                        ? Radius.circular(25)
                        : Radius.circular(25),
                    topRight: currentUser != data['sender']
                        ? Radius.circular(25)
                        : Radius.circular(25),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${data['imageUrl']}')),
                ),
              ),
            ),
          ],
        ));
  }
}

class ETextMessage extends StatelessWidget {
  final dynamic data;
  final dynamic docid;
  ETextMessage({required this.data, required this.docid});

  CollectionReference notesref =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: currentUser == data['sender']
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                  topLeft: currentUser == data['sender']
                      ? Radius.circular(35)
                      : Radius.circular(35),
                  topRight: currentUser != data['sender']
                      ? Radius.circular(35)
                      : Radius.circular(35),
                ),
                color: currentUser == data['sender']
                    ? Color.fromARGB(255, 55, 143, 125)
                    : Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: currentUser == data['sender']
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      currentUser != data['sender']
                          ? Text(
                              "${data['sender']}",
                              style: TextStyle(
                                color: Color.fromARGB(255, 55, 143, 125),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              'Me',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${data['message']}',
                        style: TextStyle(
                          color: currentUser == data['sender']
                              ? Colors.white
                              : Color.fromARGB(255, 55, 143, 125),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
