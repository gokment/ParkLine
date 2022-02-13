import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkline/Model/User.dart';
import 'package:parkline/Services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParkingHistoryScreen extends StatefulWidget {
  const ParkingHistoryScreen({Key key}) : super(key: key);

  @override
  _ParkingHistoryScreenState createState() => _ParkingHistoryScreenState();
}

class _ParkingHistoryScreenState extends State<ParkingHistoryScreen> {
  CollectionReference userData =
      FirebaseFirestore.instance.collection('userData');

  User user;
  AuthServices auth = AuthServices();
  // var id;
  var userID;

  // void getUser() async {
  //   var user = await auth.user;
  //   setState(() {
  //     user = user;
  //     id = user.uid;
  //   });
  //   print(user.uid);
  // }

  @override
  void initState() {
    // TODO: implement initState
    // getUser();
    getUserInfo();
    super.initState();
  }

  void getUserInfo() async {
    var user = await UserModel.getCurrentUserData();
    if (user != null) {
      setState(() {
        userID = user.id;
      });
    } else {
      setState(() {
        // _name = ' ';
        // _email = " ";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft),
          iconSize: 30.0,
          color: kwhite,
          onPressed: () {
            Routes.homeScreenNavigator(context);
          },
        ),
        title: Text(
          "Parking History",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w200,
            fontFamily: 'Poppins',
            color: kwhite,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: _builParkingHistory(),
      // SingleChildScrollView(
      //   child: SafeArea(
      //     child: ListView.builder(
      //         itemCount: 1,
      //         itemBuilder: (context, i) {
      //           return Card(
      //                       color: kgrey,
      //                       child: Container(
      //                         margin: EdgeInsets.only(top: 20, bottom: 20),
      //                         padding: EdgeInsets.all(10),
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Text("coupons",
      //                                     style: TextStyle(
      //                                       fontSize: 18.0,
      //                                       fontWeight: FontWeight.w900,
      //                                       fontFamily: 'Montserrat',
      //                                       color: kblack,
      //                                     )),
      //                               ],
      //                             ),
      //                             SizedBox(
      //                               height: 30,
      //                             ),
      //                             Text("date",
      //                                 style: TextStyle(
      //                                   fontSize: 18.0,
      //                                   fontWeight: FontWeight.w900,
      //                                   fontFamily: 'Montserrat',
      //                                   color: kblack,
      //                                 )),
      //                           ],
      //                         ),
      //                       ),
      //                     );;
      //         }),
      //   ),
      // ),
    );
  }

  Widget _builParkingHistory() {
    return StreamBuilder<QuerySnapshot>(
      stream: userData.doc(userID).collection("reservations").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.1,
                        child: ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return ListTile(
                              title: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Card(
                                            // decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(20.0)),
                                            margin: EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                top: 20,
                                                bottom: 20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: data['vehicule'] == "car"
                                                  ? Icon(
                                                      FontAwesomeIcons.carAlt,
                                                      size: 50.0)
                                                  : Icon(
                                                      FontAwesomeIcons
                                                          .motorcycle,
                                                      size: 50.0),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data['place']}",
                                                style: TextStyle(
                                                  fontSize: 19.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Montserrat',
                                                  color: kblack,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                "Start at ${data['start date']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Montserrat',
                                                  color: kblack,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                "End at ${data['end date']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Montserrat',
                                                  color: kblack,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${data['hourly']}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Montserrat',
                                              color: kblack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  // RaisedButton( child: Text("press me"), onPressed:() => print(userID),)
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        // ListView(
        //   children: snapshot.data.docs.map((DocumentSnapshot document) {
        //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        //     return ListTile(
        //       title: Text(data['full_name']),
        //       subtitle: Text(data['company']),
        //   );
        // }).toList(),
        // );
      },
    );
    // SingleChildScrollView(
    //   child: SafeArea(
    //     child: Column(
    //       children: [
    //         Center(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Container(
    //                 height: MediaQuery.of(context).size.height / 1.1,
    //                 child: ListView.builder(
    //                   itemCount: 22,
    //                   itemBuilder: (context, i) {
    //                     return ListTile(
    //                                               title: Column(
    //                         children: [
    //                           Center(
    //                             child: Container(
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                                 children: [
    //                                   Card(
    //                                     // decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(20.0)),
    //                                     margin: EdgeInsets.only(left: 20, right:0, top: 20, bottom: 20),
    //                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.all(20.0),
    //                                       child: Icon(FontAwesomeIcons.carAlt,
    //                                           size: 50.0),
    //                                     ),
    //                                   ),
    //                                   Column(
    //                                     children: [
    //                                       Text(
    //                                         "Parking Place",
    //                                         style: TextStyle(
    //                                           fontSize: 19.0,
    //                                           fontWeight: FontWeight.w500,
    //                                           fontFamily: 'Montserrat',
    //                                           color: kblack,
    //                                         ),
    //                                       ),
    //                                       SizedBox(height: 10.0,),
    //                                       Text(
    //                                         "date and hour",
    //                                         style: TextStyle(
    //                                           fontSize: 16.0,
    //                                           fontWeight: FontWeight.w500,
    //                                           fontFamily: 'Montserrat',
    //                                           color: kblack,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Text(
    //                                     "Hourly",
    //                                     style: TextStyle(
    //                                       fontSize: 16.0,
    //                                       fontWeight: FontWeight.w500,
    //                                       fontFamily: 'Montserrat',
    //                                       color: kblack,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                           Divider()
    //                         ],
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
