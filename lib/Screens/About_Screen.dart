import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Const/const.dart';
import 'package:parkline/Widgets/Drawer_Widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

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
          "About",
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
          Image.asset("assets/images/logo.png"),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: 
                Text(
                  "Parkline is an application developed with the aim of facilitating parking in Cameroon thanks to a reservation system for a very specific period and for a specific vehicle.",
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: kblack,
                  ),
                ),),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    " Choose your parking space, hourly rate and type of vehicle and submit your reservation",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      color: kblack,
                    ),
                  ),
                ),
          // SizedBox(
          //   height: 137.0,
          // ),
          // Text(
          //   "Developed by Mael Toukap |💡2022",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 13.0,
          //     fontWeight: FontWeight.w300,
          //     fontFamily: 'Poppins',
          //     color: kblack,
          //   ),
          // ),
        ],
      ),
    );
  }
}
