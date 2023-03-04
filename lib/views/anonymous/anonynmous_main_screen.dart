import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favourites_list.dart';
import 'listeners_list.dart';

class AnonynmousMainScreen extends StatefulWidget {
  @override
  _AnonynmousMainScreenWidgetState createState() =>
      _AnonynmousMainScreenWidgetState();
}

class _AnonynmousMainScreenWidgetState extends State<AnonynmousMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(36, 20, 63, 1),
                ),
                child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Chat Anonymously with People',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Outfit',
                            fontSize: 24,
                            letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage(
                                'assets/images/vector.png',
                              )),
                          Text('0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Outfit',
                                  fontSize: 24,
                                  letterSpacing:
                                  1 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('+ Add Money',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Outfit',
                              fontSize: 15,
                              letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                              height: 1)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Column(
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        ' Favourites',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontFamily: 'Outfit',
                                            fontSize: 20,
                                            letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.bold,
                                            height: 1)),
                                  ),
                                ),
                                FavouritesList(),
                                SizedBox(
                                  height: 10,
                                ),
                                ListenersList()
                              ]
                          )
                      ),
                    ]
                )
            )
        )
    );
  }
}
