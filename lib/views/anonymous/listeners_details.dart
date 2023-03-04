import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untvoice/views/anonymous/dial_screen.dart';

import '../../controller/api_data.dart';

class ListenerDetailsScreen extends StatefulWidget {
  const ListenerDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ListenerDetailsScreen> createState() => _ListenerDetailsScreenState();
}

class _ListenerDetailsScreenState extends State<ListenerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return SafeArea(
      child: Container(
        color: Color.fromARGB(255, 240, 240, 240),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Image.asset('assets/anonymous_profile_screen/background.png'),
                      SizedBox(
                        height: 45,
                      ),
                    ],
                  ),
                  Positioned(
                      left: MediaQuery.of(context).size.width/2 - 40,
                      top: MediaQuery.of(context).size.width/2 - 40,
                      child: Container(
                          height: 80,
                          width: 80,
                          child: Image.network(data['imageUrl'])
                      )
                  ),
                ],
              ),
              myText(data['first'], 20, FontWeight.w900),
              myText('${data['age']} Yrs', 14, FontWeight.w800),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width*.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.60),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                        ),
                        myText('About Me', 17, FontWeight.w900,),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Text(data['longDetails'], style: TextStyle(fontSize: 15, fontFamily: 'Roboto',
                            color: Colors.black,
                            decoration: TextDecoration.none), textAlign: TextAlign.justify,),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width*.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.13,
                      width: MediaQuery.of(context).size.width*.37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.60),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myText('Ratings', 17, FontWeight.w900),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/anonymous_profile_screen/star.png'),
                                Container(
                                  width: 7,
                                ),
                                myText('4.6', 28, FontWeight.w900),
                              ],
                            ),
                          ),
                          myText('100+ Reviews', 17, FontWeight.w400),
                          Container(height: 5)
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.13,
                      width: MediaQuery.of(context).size.width*.37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.60),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myText('Charges', 17, FontWeight.w900),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            height: 40,
                            child: myText('₹ ${data['rate']}', 28, FontWeight.w900),
                          ),
                          myText('per minute', 17, FontWeight.w400),
                          Container(height: 5)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                height: MediaQuery.of(context).size.height*0.09,
                width: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.60),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myText('Available at:', 19, FontWeight.w900),
                    GestureDetector(
                      onTap: () async {
                          String? currentUserUid = FirebaseAuth.instance.currentUser?.uid.toString();
                          String channelId = "$currentUserUid'_'$data['uid']";
                          // var token = await getData(channelId);
                          final String token = await getData(channelId);

                          print(token);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (builder) => DialScreen(token, channelId, currentUserUid!)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/anonymous_profile_screen/call.png',
                            scale: 2.5,
                          ),
                          myText('Call', 17, FontWeight.w900),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement Chat
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/anonymous_profile_screen/chat.png',
                            scale: 2.5,
                          ),
                          myText('Chat', 16, FontWeight.w900),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget myText (String text, double size, FontWeight fontWeight) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        fontFamily: 'Roboto',
        color: Colors.black,
        decoration: TextDecoration.none
    ),
  );
}
