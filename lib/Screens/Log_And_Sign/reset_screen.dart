import 'package:parkline/Widgets/loading.dart';
import 'package:parkline/Const/const.dart';

import 'package:parkline/services/auth_service.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthServices auth = AuthServices();
  String email, msg = "";
  final keys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: keys,
            child: Column(
              children: [
                Text("Login", style: style),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (e) => email = e,
                  validator: (e) => e.isEmpty ? "Champ vide" : null,
                  decoration: InputDecoration(
                      hintText: "Entrer votre email", labelText: "Email"),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (keys.currentState.validate()) {
                      loading(context);
                      bool send = await auth.resetpassword(email);
                      if (send) {
                        msg =
                            "Accéder à votre email pour reinitialiser votre mot de passe";
                        Navigator.of(context).pop();
                        setState(() {});
                      }
                    }
                  },
                  child: Text("Envoyer"),
                ),
                Text(msg, style: style.copyWith(color: Colors.green))
              ],
            ),
          ),
        ),
      )),
    );
  }
}








// class ResetScreen extends StatefulWidget {
//   @override
//   _ResetScreenState createState() => _ResetScreenState();
// }

// class _ResetScreenState extends State<ResetScreen> {
//   // TextEditingController _email = TextEditingController();
//   String Msg = "", _email;
//   final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
// //   ScaffoldMessenger.of(context).showSnackBar(snackBar);

//   // @override
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Widget _buildEmail() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[600].withOpacity(0.5),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: TextFormField(
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(vertical: 20),
//             border: InputBorder.none,
//             hintText: 'Email',
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Icon(
//                 FontAwesomeIcons.envelope,
//                 color: Colors.white,
//                 // size: 30,
//                 size: 25,
//               ),
//             ),
//           ),
//           validator: (String value) {
//             if (value.isEmpty) {
//               return "L'email est requis";
//             }

//             if (!RegExp(
//                     r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//                 .hasMatch(value)) {
//               return 'Entrez un email valide';
//             }

//             return null;
//           },
//           onChanged: (value) => _email = value,
//           // controller: _email,
//           // onSaved: (String value) {
//           //   _email = value;
//           // },
//         ),
//       ),
//     );
//   }

//   AuthServices auth = AuthServices();
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         BackgroundImage(),
//         Scaffold(
//             backgroundColor: Colors.transparent,
//             body: SingleChildScrollView(
//               child: SafeArea(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 150,
//                       child: Center(
//                         child: Text(
//                           'ParkLine',
//                           style: kHeading,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             _buildEmail(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 7,
//                           ),
//                           new RoundedButton(
//                             buttonText: 'Reinitialiser',
//                             onPressed: () async {
//                               print("btn click");
//                               if (_formKey.currentState.validate()) {
//                                 loading(context);
//                                 print(_email);
//                                 bool reset = await auth.resetpassword(_email);
//                                 if (reset) {
//                                   Msg =
//                                       "Acceder a votre email pour reinitialiser votre mot de passe";
//                                   setState(() {});
//                                 }
//                                 if (reset != null) {
//                                   Navigator.of(context).pop();
//                                   if (!reset)
//                                     print("email ou mot de passe incorrecte");
//                                 }
//                               }

//                               _formKey.currentState.save();

//                               print(this._email);
//                               // final snackBar = SnackBar(
//                               //   content: Text('Yay! A SnackBar!'),
//                               //   action: SnackBarAction(
//                               //     label: 'Undo',
//                               //     onPressed: () {
//                               //       // Some code to undo the change.
//                               //     },
//                               //   ),);
//                               // // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                               // Scaffold.of(context).showSnackBar(snackBar);
//                             },
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                             child: Text(
//                               Msg,
//                               style: messagesGreen,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ))
//       ],
//     );
//   }
// }
