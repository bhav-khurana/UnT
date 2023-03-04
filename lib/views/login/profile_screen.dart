import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import '../../widgets/my_widgets.dart';
import '../../controller/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String phone;
  const ProfileScreen(this.phone, {super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dob.text = '${picked.day}-${picked.month}-${picked.year}';
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dob = TextEditingController();

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  int selectedRadio = 0;

  AuthController? authController;

  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: Get.width * 0.2,
                ),
                textField(
                    text: 'First Name',
                    controller: firstNameController,
                    validator: (String input) {
                      if (firstNameController.text.isEmpty) {
                        Get.snackbar('Warning', 'First Name is required.',
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                    }),
                textField(
                    text: 'Last Name',
                    controller: lastNameController,
                    validator: (String input) {
                      if (lastNameController.text.isEmpty) {
                        Get.snackbar('Warning', 'Last Name is required.',
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                    }),
                Container(
                  height: 48,
                  child: TextField(
                    controller: dob,
                    // enabled: false,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());

                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      suffixIcon: Image.asset(
                        'assets/login/calender.png',
                        cacheHeight: 20,
                      ),
                      hintText: 'Date Of Birth',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          child: RadioListTile(
                            title: Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                                color: AppColors.genderTextColor,
                              ),
                            ),
                            value: 0,
                            groupValue: selectedRadio,
                            onChanged: (int? val) {
                              setSelectedRadio(val!);
                            },
                          ),
                        )),
                    Expanded(
                      child: Container(
                        child: RadioListTile(
                          title: Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: AppColors.genderTextColor,
                            ),
                          ),
                          value: 1,
                          groupValue: selectedRadio,
                          onChanged: (int? val) {
                            setSelectedRadio(val!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(()=> authController!.isProfileInformationLoading.value? Center(child: CircularProgressIndicator(),) :Container(
                  height: 50,
                  margin: EdgeInsets.only(top: Get.height * 0.02),
                  width: Get.width,
                  child: elevatedButton(
                    text: 'Save',
                    onpress: () async{
                      if (dob.text.isEmpty) {
                        Get.snackbar(
                            'Warning', "Date of birth is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }

                      if (!formKey.currentState!.validate()) {
                        return null;
                      }

                      authController!.isProfileInformationLoading(true);

                      FirebaseAuth auth = FirebaseAuth.instance;
                      String uid = auth.currentUser!.uid;

                      authController!.uploadProfileData(firstNameController.text.trim(), lastNameController.text.trim(),
                          dob.text.trim(), widget.phone.trim(), selectedRadio ==0 ? "Male": "Female",uid);
                    },
                  ),
                )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                    width: Get.width * 0.8,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'By signing up, you agree our ',
                            style: TextStyle(
                                color: Color(0xff262628), fontSize: 12)),
                        TextSpan(
                            text: 'terms, Data policy and cookies policy',
                            style: TextStyle(
                                color: Color(0xff262628),
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ]),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}