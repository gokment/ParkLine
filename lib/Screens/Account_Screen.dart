import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Const/const.dart';
import 'package:parkline/Model/User.dart';
import 'package:parkline/Services/auth_service.dart';
import 'package:parkline/Services/db.dart';
import 'package:parkline/Widgets/InkButton.dart';
import 'package:parkline/Widgets/loading.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final keys = GlobalKey<FormState>();
  AuthServices auth = AuthServices();
  var email = 'Email';
  var username = 'Username';
  var pass = 'Password';
  var uid = 'Password';
  String _error = " ";
  @override

  // Initially password is obscure
  bool obscureText = true;
  bool isOk = false;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void getUserInfo() async {
    var user = await UserModel.getCurrentUserData();
    if (user != null) {
      setState(() {
        if (user.id != null) uid = user.id;
        if (user.email != null) email = user.email;
        if (user.username != null) username = user.username;
      });
    } else {
      setState(() {
        // _name = ' ';
        // _email = " ";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  // Widget _buildPassword() {
  //   return
  //       // Column(
  //       // children: [
  //       TextFormField(
  //     decoration: InputDecoration(
  //       icon: new Icon(FontAwesomeIcons.userLock),
  //       labelText: 'Mot de passe',
  //     ),

  //     keyboardType: TextInputType.visiblePassword,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return "Le champs mdp est requis";
  //       } else if (value.length < 8) {
  //         return "Le mot de passe doit comporter au moins 8 caractères";
  //       }

  //       return null;
  //     },
  //     controller: _password,
  //     // onSaved: (value) => _password = value,
  //     obscureText: obscureText,
  //     // onSaved: (String value) {
  //     //   _password = value;
  //     // },
  //   );

  //   // IconButton(
  //   //   onPressed: _toggle,
  //   //   icon: FaIcon(obscureText ? FontAwesomeIcons.eye: FontAwesomeIcons.eyeSlash),
  //   // ),],
  //   // );
  // }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
          margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
          decoration: BoxDecoration(
            // color: Colors.grey[600].withOpacity(0.4),
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              border: InputBorder.none,
              hintText: '$username',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  FontAwesomeIcons.userAlt,
                  color: Colors.blueAccent,
                  // size: 30,
                  size: 25,
                ),
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Username is required. You can enter your old username*';
              }

              return null;
            },
            controller: _username,
          )),
    );
  }

  Widget _buildEmail() {
    getUserInfo();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
          margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
          decoration: BoxDecoration(
            // color: Colors.grey[600].withOpacity(0.4),
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              border: InputBorder.none,
              hintText: '$email',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  FontAwesomeIcons.solidEnvelope,
                  color: Colors.blueAccent,
                  // color: Colors.blueAccent,
                  // size: 30,
                  size: 25,
                ),
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Email is required. You can enter your old Email*';
              }

              if (!RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
                return 'Entrez un email valide';
              }

              return null;
            },
            controller: _email,
          )),
    );
  }

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
        // Icon(
        //   FontAwesomeIcons.angleLeft,
        //   size: 40.0,
        // ),
        title: Text(
          "My Account",
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
      body: ListView(
        children: [
          SizedBox(
            height: 60.0,
          ),
          CircleAvatar(
            // backgroundColor: Colors.blueAccent,
            backgroundColor: korange,
            radius: 70.0,
            child: Icon(
              Icons.person,
              size: 60.0,
              color: Colors.white,
            ),
            // Column(
            //   children: [
            // Icon(Icons.person),
            // Padding(
            //   padding: const EdgeInsets.only(left: 90.0, top: 70.0),
            //   child: InkWell(
            //     onTap: () {
            //       print("object");
            //     },
            //     child: Container(
            //       width: 40.0,
            //       height: 40.0,
            //       // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            //       decoration: BoxDecoration(
            //           color: Colors.blueAccent,
            //           borderRadius: BorderRadius.circular(50.0)),
            //       child: Center(
            //           child: Icon(
            //         FontAwesomeIcons.camera,
            //         color: kblack,
            //       )
            //           // Text(
            //           //   "CONFIRM",
            //           //   style: TextStyle(fontSize: 16.0, color: Colors.white),
            //           // ),
            //           ),
            //     ),
            //   ),
            // ),
            //   ],
            // ),
          ),
          SizedBox(
            height: 80.0,
          ),
          // Spacer(),
          Form(
            key: keys,
            child: Column(
              children: [
                _buildName(),
                _buildEmail(),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              // color: Color(0xfff9A826),
              borderRadius: BorderRadius.circular(16),
            ),
            child: FlatButton(
              onPressed: () async {
                if (keys.currentState.validate()) {
                  loading(context);
                  // print(_email.text + "    " + _password.text);
                  bool login = await auth.updateUserCredentials(
                      _email.text, _username.text, uid);
                  print(_username.text);
                  print(_email.text);
                  print(login);
                  if (login != false) {
                    if (login != null) {
                      setState(() {
                        Navigator.of(context).pop();
                        _error = "Changes saved successfully";
                      });

                      Routes.statutAuthNavigator(context);
                    }
                    // print("Incorrect email or password");
                  }
                  else if (!login)
                    setState(() {
                      Navigator.of(context).pop();
                        _error = "Changes have not been saved";
                    });
                  else {
                    setState(() {
                      Navigator.of(context).pop();
                      _error = "Network error please check your connexion";
                    });
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Modify",
                  style: kBodyText,
                ),
              ),
            ),
          ),
          // InkButton(
          //     tapMethod: () async {
          //       if (keys.currentState.validate()) {
          //         loading(context);
          //         print(_email.text + "    " + _password.text);
          //         bool update = await auth.updateUserCredentials(
          //             _email.text, _password.text);
          //         // print(login);
          //         if (update != false) {
          //           if (update != null) {
          //             setState(
          //               () {
          //                 Navigator.of(context).pop();
          //                 _error = "Changes saved successfully";
          //               },
          //             );
          //           }
          //           if (!update)
          //             setState(
          //               () {
          //                 Navigator.of(context).pop();
          //               },
          //             );
          //         }
          //       }
          //     },
          //     textButton: "MODIFY",
          //     iconButton: Icon(
          //       FontAwesomeIcons.lock,
          //       color: kwhite,
          //     )),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "$_error",
              style: TextStyle(color: Colors.redAccent, fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
