import 'package:parkline/Model/User.dart';
import 'package:parkline/Screens/Home_Screen.dart';
import 'package:parkline/Screens/Log_And_Sign/login_screen.dart';
import 'package:parkline/Services/db.dart';
import 'package:parkline/screens/Log_And_Sign/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:parkline/Services/auth_service.dart';
import 'package:provider/provider.dart';

// class StatutAuth extends StatefulWidget {
//   @override
//   _StatutAuthState createState() => _StatutAuthState();
// }

// class _StatutAuthState extends State<StatutAuth> {
//   bool visible = true;
//   bool login = false;

//   isConnected() async {
//     var User = await UserModel.getCurrentUserData();

//     if (UserModel.sessionUser == null) {
//       setState(() {
//         login = false;
//       });
//     } else {
//       // print(User['name']);
//       setState(() {
//         login = true;
//       });
//     }
//   }

//   toggle() {
//     setState(() {
//       visible = !visible;
//     });
//   }

//   isLoggin() {
//     setState(() {
//       login = !login;
//     });
//   }

//   @override
//   void initState() {
//     isConnected();
//   }

//   Widget build(BuildContext context) {
//     return login
//         ? HomeScreen()
//         : visible
//             ? LoginPage()
//             : Register();
//   }
// }

class StatutAuth extends StatefulWidget {
  @override
  _StatutAuthState createState() => _StatutAuthState();
}

class _StatutAuthState extends State<StatutAuth> {
  // AuthServices auth = AuthServices();
  // User user;
  var userID;

  // void getUser() async {
  //   var user = await auth.user;
  //   setState(() {
  //     user = user;
  //     id = user.uid;
  //   });
  //   print(user.uid);
  // }

//   AuthServices auth = AuthServices();
//  // Set default home.
//   Widget _defaultHome = new LoginPage();

//   // Get result of the login function.
//   bool _result = auth.isLog = true;
//   if (_result) {
//     _defaultHome = new HomePage();
//   }

  @override
  void initState() {
    // TODO: implement initState
    // getUser();
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    var user = await UserModel.getCurrentUserData();
    if (user != null) {
      setState(() {
        userID = user.id;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(userID);
    return userID == null ? LoginPage() : HomeScreen();
  }
}
