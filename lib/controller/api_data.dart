
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

Future<String> getData(String channel) async {
  String? current_uid = FirebaseAuth.instance.currentUser?.uid.toString();
  try{
    final Response response = await get(Uri.parse("https://untangled.onrender.com/rtc/$channel/audience/$current_uid"));
    Map data = jsonDecode(response.body);
    FirebaseFirestore.instance.collection('users')
        .doc(current_uid)
        .set({
      'rtcToken': data["rtcToken"]
    },SetOptions(merge: true)).then((value){
    });
    return data["rtcToken"] as String;
  } catch(e) {
    debugPrint("getAgoraChannelToken: $e");
  }
  return "";
}
