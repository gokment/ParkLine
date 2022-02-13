import 'package:flutter/material.dart';
import 'package:parkline/Screens/Account_Screen.dart';
import 'package:parkline/Screens/About_Screen.dart';
import 'package:parkline/Screens/Home_Screen.dart';
import 'package:parkline/Screens/Log_And_Sign/register_screen.dart';
import 'package:parkline/Screens/Log_And_Sign/login_screen.dart';
import 'package:parkline/Screens/Log_And_Sign/reset_screen.dart';
import 'package:parkline/Screens/ParkingHistory_Screen.dart';
import 'package:parkline/Screens/status_auth.dart';
// Naigators
class Routes {

  static void loginScreenNavigator(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginPage();
        },
      ),
    );
  }
  static void signinScreenNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return Register();
        },
      ),
    );
  }
  static void resetPasswordScreenNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return ResetPassword();
        },
      ),
    );
  }
  static void statutAuthNavigator(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return StatutAuth();
        },
      ),
    );
  }
  static void homeScreenNavigator(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return HomeScreen();
        },
      ),
    );
  }
  static void accountScreenNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return AccountScreen();
        },
      ),
    );
  }
  static void contactsScreenNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return AboutScreen();
        },
      ),
    );
  }
  static void parkingHistoryScreenNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return ParkingHistoryScreen();
        },
      ),
    );
  }
}