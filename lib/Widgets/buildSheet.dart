import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkline/Const/const.dart';
import 'package:parkline/Model/User.dart';
import 'package:parkline/Services/db.dart';
import 'package:parkline/Widgets/long_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:parkline/Services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuildSheetWidget extends StatefulWidget {
  final passedName;
  const BuildSheetWidget({Key key, this.passedName}) : super(key: key);
  // const BuildSheetWidget({Key key}) : super(key: key);

  @override
  _BuildSheetWidgetState createState() => _BuildSheetWidgetState();
}

class _BuildSheetWidgetState extends State<BuildSheetWidget> {
  var currentSelectedValue;
  var deviceTypes = ["Hour", "Week", "Month"];
  Color carColor = Colors.orange;
  Color bikeColor = kblack;
  String vehicule = "car";
  String error = "";
  var username;
  bool isLoading = false;
  bool isDone = false;
  var endDate;
  // var id;
  var userID;
  var email = "user@user.com";
  var splittedEmailName;
  final DateTime today = DateTime.now();
// var _startDate = DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now()).toString();

  // var date = DateFormat.yMd().add_jm().format(DateTime.now());
  var startDate = DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now());
  // DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CollectionReference markers =
      FirebaseFirestore.instance.collection('markers');
  CollectionReference userData =
      FirebaseFirestore.instance.collection('userData');
  CollectionReference reservations =
      FirebaseFirestore.instance.collection('reservations');

  // User user;
  // AuthServices auth = AuthServices();

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
        if (user.id != null) userID = user.id;
        if (user.email != null) email = user.email;
        if (user.username != null) username = user.username;
        var string = "$email";
        splittedEmailName = string.split('@')[0];
      });
    } else {
      return null;
    }
  }
  // void getUser() async {
  //   var user = await auth.user;
  //   setState(() {
  //     user = user;
  //     id = user.uid;
  //   });
  // }

  Future<void> addReservations() {
    reservations.doc(widget.passedName['markerID']).collection("markers").add({
      'start date': "$startDate",
      'end date': "$endDate",
      'isReserve': true
    });
    String message =
        "Hi I am the user $userID; --@$username; --$email; I would like to book a place in ${widget.passedName['place']} from $startDate until $endDate";
    // Call the user's CollectionReference to add a new user
    return userData.doc(userID).collection("reservations").add({
      'place': widget.passedName['place'], // set location place
      'vehicule': "$vehicule", // set vehicule type
      'coords': widget.passedName['coords'], // set coords location
      'hourly': "$currentSelectedValue",
      'start date': "$startDate", // set start Date
      'end date': "$endDate", // set end Date
      'user': userID //set userID
      // 'user': "bcnKTouM8meESJZZRAFDy4Egyj13" // 42
    }).then((value) {
      print("reservations Added");
      setState(() {
        isLoading = false;
        isDone = true;

      DBServices().share(message, 237696886292);
      });
    }).catchError((error) {
      print("Failed to add reservations: $error");
      setState(() {
        isLoading = false;
        isDone = true;
      });
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // getUser();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.75,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(23),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: controller,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Text(
                  username != null ? "Hi $username" : "Hi $splittedEmailName",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                ),
              ),
              Text(
                "Do you want to park at ${widget.passedName['place']} ?",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Choose your vehicule type",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                          fontSize: 18.0),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.motorcycle,
                        color: bikeColor,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            vehicule = 'motorcycle';
                            bikeColor = Colors.orange;
                            carColor = kblack;
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.car,
                        color: carColor,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            vehicule = 'car';
                            carColor = Colors.orange;
                            bikeColor = kblack;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 0),
                child: Form(
                  key: _formKey,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text("Choose your hourly rate"),
                            value: currentSelectedValue,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                currentSelectedValue = newValue;
                              });
                              if (currentSelectedValue == "Hour") {
                                setState(
                                  () {
                                    endDate = DateFormat('dd/MM/yyyy kk:mm')
                                        .format(DateTime.now()
                                            .add(Duration(hours: 1)))
                                        .toString();
                                  },
                                );
                              } else if (currentSelectedValue == "Week") {
                                setState(
                                  () {
                                    endDate = DateFormat('dd/MM/yyyy kk:mm')
                                        .format(DateTime.now()
                                            .add(Duration(days: 7)))
                                        .toString();
                                  },
                                );
                              } else if (currentSelectedValue == "Month") {
                                setState(
                                  () {
                                    endDate = DateFormat('dd/MM/yyyy kk:mm')
                                        .format(DateTime.now()
                                            .add(Duration(days: 30)))
                                        .toString();
                                  },
                                );
                              } else {
                                return null;
                              }
                              print(currentSelectedValue);
                            },
                            items: deviceTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (String value) {
                      if (currentSelectedValue == null) {
                        setState(() {
                          error = "Hourly is require";
                        });
                        return "Hourly is require";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              // LongFilterWidget(),
              SizedBox(
                height: 2.0,
              ),
              Text(
                "$error",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 7.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: isLoading == false && isDone == false
                    ? InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            // print(vehicule);
                            setState(() {
                              isLoading = true;
                            });
                            addReservations();
                            // Navigator.pop(context);
                            // print(endDate);
                          }
                          // addUser();
                          //                 await FirebaseFirestore
                          // .instance
                          // .collection('reservations')
                          // .doc('bcnKTouM8meESJZZRAFDy4Egyj13').set(data)
                          // .add({

                          //add your data that you want to upload
                          // });
                          // print(currentSelectedValue + widget.passedName['place']);
                        },
                        child: Container(
                          width: 20.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Center(
                            child: Text(
                              "CONFIRM",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 20.0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(7.0)),
                        child: Center(
                          child: isDone == false
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      backgroundColor: kwhite,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "PLEASE WAIT...",
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white),
                                    ),
                                  ],
                                )
                              : Icon(
                                  FontAwesomeIcons.solidCheckCircle,
                                  color: kwhite,
                                  size: 30.0,
                                ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeDismissible({Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
