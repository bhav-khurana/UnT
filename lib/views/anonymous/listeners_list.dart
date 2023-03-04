import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/api_data.dart';
import '../../controller/data_controller.dart';
import 'listeners_details.dart';

class ListenersList extends StatefulWidget {
  @override
  State<ListenersList> createState() => _ListenersListState();
}

class _ListenersListState extends State<ListenersList> {

  final DataController controller = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getLoginUserProduct();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: double.infinity,
      child: GetBuilder<DataController>(
        builder: (controller) => controller.listenersList.isEmpty
            ? Center(
          child: Text('😔 NO DATA FOUND PLEASE ADD DATA 😔'),
        )
            : ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: controller.listenersList.length,
          separatorBuilder: (context, _) =>
          const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(() => ListenerDetailsScreen(), arguments: {
                  'first': controller.listenersList[index].firstname,
                  'rate': controller.listenersList[index].charges,
                  'age': controller.listenersList[index].age,
                  'longDetails': controller.listenersList[index].longDetails,
                  'imageUrl': controller.listenersList[index].image,
                  'uid': controller.listenersList[index].uid,
                });
              },
              child: Container(
                height: 75.0,
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Container(
                      width: 356,
                      height: 75,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              top: 0,
                              left: 10,
                              child: Container(
                                  width: 70,
                                  height: 70,
                                  child: Image.network(controller
                                      .listenersList[index].image),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(75, 75)),
                                  ))),
                          Positioned(
                              top: 1,
                              left: 102,
                              child: Text(
                                controller
                                    .listenersList[index].firstname,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Outfit',
                                    fontSize: 19,
                                    letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.bold,
                                    height: 1),
                              )),
                          Positioned(
                              top: 27,
                              left: 104,
                              child: Container(
                                width: 198,
                                height: 33,
                                child: Text(
                                  controller.listenersList[index]
                                      .shortDetails,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          127, 127, 127, 1),
                                      fontFamily: 'Outfit',
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              )),
                          Positioned(
                              top: 3,
                              left: 300,
                              child: Text(
                                '${controller.listenersList[index].age} Yrs',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Outfit',
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
