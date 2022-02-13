import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Model/User.dart';
import 'package:parkline/Services/auth_service.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  AuthServices auth = AuthServices();
  var userID;
  var email;
  var username;
  var splittedEmailName;
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
        if (user.id != null) userID = user.id;
        if (user.email != null) email = user.email;
        if (user.username != null) username = user.username;
        var string = "$email";
        splittedEmailName = string.split('@')[0];
        // final string = "$email";
        // final re = RegExp(r'@*');

        // print(string.split(re));
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      color: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username != null ?"$username":"$splittedEmailName"),
            accountEmail: Text("$email"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.history),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'Parking History',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.parkingHistoryScreenNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.userAlt),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'My Account',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.accountScreenNavigator(context);
            },
          ),
          // Divider(),
          // ListTile(
          //   title: Row(
          //     children: [
          //       Icon(FontAwesomeIcons.cog),
          //       SizedBox(
          //         width: 15.0,
          //       ),
          //       Text(
          //         'Change to French',
          //         style: TextStyle(fontSize: 19.0),
          //       )
          //     ],
          //   ),
          //   onTap: () {
          //     // Routes.HomeNavigator(context);
          //   },
          // ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                // Icon(FontAwesomeIcons.idCard),
                Icon(FontAwesomeIcons.info),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'About',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.contactsScreenNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.signOutAlt),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              UserModel.logOut();
              Routes.statutAuthNavigator(context);
              // await auth.signOut();
              // Routes.HomeNavigator(context);
            },
          ),
        ],
      ),
    );
  }
}
