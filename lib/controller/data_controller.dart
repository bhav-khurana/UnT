import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untvoice/controller/common_dialog.dart';
import 'package:untvoice/models/anonymous_listeners_model.dart';

class DataController extends GetxController {
  final firebaseInstance = FirebaseFirestore.instance;
  final Map<String, dynamic> userData = {'first': '', 'last': '', 'gender':'','dob':'','mob':''};
  List<ListenerData> listenersList = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getUserProfileData() async {
    try {
      CommonDialog.showLoading();
      var response = await firebaseInstance
          .collection('users')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .get();
      if (response.docs.isNotEmpty) {
        userData['first'] = response.docs[0]['first'];
        userData['last'] = response.docs[0]['last'];
        userData['gender'] = response.docs[0]['gender'];
        userData['dob'] = response.docs[0]['dob'];
        userData['mob'] = response.docs[0]['mob'];
      }
      CommonDialog.hideLoading();
    } on FirebaseException catch (e) {
      print("firebase exception");
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();
      print(e);
    } catch (error) {
      CommonDialog.hideLoading();
      print("any other error");
      CommonDialog.showErrorDialog();
      print(error);
    }
  } // @override

  Future<void> getLoginUserProduct() async {
    listenersList=[];
    try {
      CommonDialog.showLoading();
      var response = await firebaseInstance
          .collection('counsellor_anonymous')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          listenersList.add(ListenerData(
            charges: result['charges'],
            dob: result['dob'],
            age: result['age'],
            firstname: result['first'],
            gender: result['gender'],
            image: result['image'],
            longDetails: result['longDetails'],
            mobileNumber: result['mobileNumber'],
            shortDetails: result['shortDetails'],
            uid: result.id,
            work: result['work'],
          ));
        }
      }
      update();
      CommonDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();
      print("Error $e");
    } catch (error) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();
      print("error $error");
    }
  }
}


