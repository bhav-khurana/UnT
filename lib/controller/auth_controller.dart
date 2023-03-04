import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:untvoice/views/home_screen.dart';

class AuthController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;
  var isProfileInformationLoading = false.obs;

  uploadProfileData(String firstName, String lastName,
      String dob,String mob, String gender,String uid) {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'first': firstName,
      'last': lastName,
      'dob': dob,
      'uid': uid,
      'gender': gender,
      'mob': mob
    }).then((value) {
      isProfileInformationLoading(false);
      Get.offAll(()=> HomeScreen());
    });
  }
}