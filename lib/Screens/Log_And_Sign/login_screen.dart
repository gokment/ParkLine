import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Screens/Home_Screen.dart';
import 'package:parkline/Screens/Log_And_Sign/reset_screen.dart';
import 'package:parkline/Widgets/devider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkline/Widgets/loading.dart';
import 'package:parkline/Services/auth_service.dart';
import 'package:parkline/Widgets/background-image.dart';
import 'package:parkline/Widgets/rounded-button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:parkline/Const/const.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthServices auth = AuthServices();
  // String email, pass;

  final keys = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _error = " ";
  // String _password;
  // @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: 'Email',
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.envelope,
                color: Colors.white,
                // size: 30,
                size: 25,
              ),
            ),
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return "Email is required";
            }

            if (!RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return 'Enter a valid email';
            }

            return null;
          },
          // onChanged: (value) => _email = value,
          controller: _email,
          // onSaved: (String value) {
          //   _email = value;
          // },
        ),
      ),
    );
  }

  // Initially password is obscure
  bool obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: 'Password',
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.userLock,
                color: Colors.white,
                // size: 30,
                size: 25,
              ),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (String value) {
            if (value.isEmpty) {
              return "Password is required";
            } else if (value.length < 8) {
              return "Password must be at least 8 characters";
            }

            return null;
          },
          // onSaved: (value) => _password = value,
          controller: _password,
          obscureText: obscureText,
          // onSaved: (String value) {
          //   _password = value;
          // },
        ),
      ),
    );

    // IconButton(
    //   onPressed: _toggle,
    //   icon: FaIcon(obscureText ? FontAwesomeIcons.eye: FontAwesomeIcons.eyeSlash),
    // ),],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: Center(
                      child: Text(
                        'PARKLINE',
                        style: kHeading,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    margin: EdgeInsets.all(24),
                    child: Form(
                      key: keys,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildEmail(),
                          _buildPassword(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                child: Text("Forgot your password ?",
                                    style: TextStyle(color: Colors.lightBlue)),
                                onPressed: () {
                                  Routes.resetPasswordScreenNavigator(context);
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (ctx) => ResetPassword()));
                                },
                              ),
                            ],
                          ),
                          // SizedBox(height: 100),
                          // ButtonTheme(
                          //   minWidth: 300.0,
                          //   buttonColor: Colors.blueAccent,
                          //   child: RaisedButton(
                          //     child: Text(
                          //       "SE CONNECTER",
                          //       style: GoogleFonts.montserrat(
                          //           color: Colors.white,
                          //           fontSize: 16,
                          //           letterSpacing: 2.0),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Container(
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
                                print(_email.text + "    " + _password.text);
                                bool login = await auth.signin(
                                    _email.text, _password.text);
                                // print(login);
                                if (login != false) {
                                  if (login != null) {
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });

                                    Routes.statutAuthNavigator(context);
                                  }
                                  // print("Incorrect email or password");
                                }
                                if (!login)
                                  setState(() {
                                      Navigator.of(context).pop();
                                    _error = "Incorrect email or password";
                                  });
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                "Sign In",
                                style: kBodyText,
                              ),
                            ),
                          ),
                        ),
                        //     RaisedButton(
                        //   onPressed: () async {
                        //     if (keys.currentState.validate()) {
                        //       loading(context);
                        //       print(_email.text + "    " + _password.text);
                        //       bool login =
                        //           await auth.signin(_email.text, _password.text);
                        //       if (login != null) {
                        //         setState(() {
                        //           Navigator.of(context).pop();
                        //         });
                        //         Routes.statutAuthNavigator(context);
                        //         if (!login) print("Incorrect email or password");
                        //       }
                        //     }
                        //   },
                        //   child: Text("Sign In"),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't you have an account ?"),
                              FlatButton(
                                  onPressed: () {
                                    Routes.signinScreenNavigator(context);
                                  },
                                  child: Text("register",
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 16)))
                            ],
                            // onPressed: () =>
                            //     MyNavigator.signinScreenNavigator(context)
                            // duration: Duration(milliseconds: 300),
                            // curve: Curves.easeIn),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "$_error",
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 17),
                        )
                        // DotDivider(),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     // ElevatedButton.icon(
                        //     //   onPressed: null, label: Text("Commander", style: GoogleFonts.montserrat(
                        //     //     color: Colors.red
                        //     // ),),icon: Icon( FontAwesomeIcons.shoppingBag, color: Colors.white,), ),
                        //     ApiRowButton(
                        //       ApiButtonColor: Colors.red,
                        //       buttonText: "GOOGLE",
                        //       onPressed: () {
                        //         print("google");
                        //         // await AuthService().SignInWithGoogle().then((UserCredential value){
                        //         //   final displayName = value.user.displayName;
                        //         //
                        //         //   print(displayName);
                        //         //
                        //         //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                        //         // });
                        //         // loading(context);
                        //         final provider =
                        //             Provider.of<GoogleSignInProvider>(context,
                        //                 listen: false);
                        //         provider.login();
                        //       },
                        //       icon: Icon(
                        //         FontAwesomeIcons.google,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     ApiRowButton(
                        //       ApiButtonColor: Colors.blueAccent,
                        //       buttonText: "FACEBOOK",
                        //       onPressed: () async {
                        //         // loading(context);
                        //         print("facebook");
                        //        await LoginWithFacebook().handleLogin();
                        //         // if (LoginWithFacebook().handleLogin() != null) {
                        //         //   Navigator.of(context).pop();
                        //         //   if (!LoginWithFacebook().handleLogin())
                        //         //     print("Network error please retry later");
                        //         // }
                        //         // final login = await logg().loginWithFB();
                        //         // print("--------------$login----------");
                        //         // if (logg().isLoggedIn = true) {
                        //         //   Navigator.push(
                        //         //     context,
                        //         //     MaterialPageRoute(
                        //         //       builder: (BuildContext context) {
                        //         //         return HomePage();
                        //         //       },
                        //         //     ),
                        //         //   );
                        //           // Navigator.of(context).pop();
                        //         //   if (!login)
                        //         //     print("email ou mot de passe incorrecte");
                        //         // };
                        //         // LoginWithFacebook();
                        //         print("yes");
                        //       },
                        //       icon: Icon(
                        //         FontAwesomeIcons.facebook,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     // Text("GOOGLE",
                        //     //   style: kBodyText,
                        //     // ),
                        //     // Text("FACEBOOK",
                        //     //   style: kBodyText,
                        //     // ),
                        //   ],
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Center(
          //     child: SingleChildScrollView(
          //   child: Container(
          //     padding: EdgeInsets.all(15),
          //     child: Form(
          //       key: keys,
          //       child: Column(
          //         children: [
          //           Text(
          //             "ParkLine",
          //             //  style: style,
          //           ),
          //           _buildEmail(),
          //           _buildPassword(),
          //           // SizedBox(
          //           //   height: 15,
          //           // ),
          //           // TextFormField(
          //           //   keyboardType: TextInputType.emailAddress,
          //           //   onChanged: (e) => email = e,
          //           //   validator: (e) => e.isEmpty ? "Champ vide" : null,
          //           //   decoration: InputDecoration(
          //           //       hintText: "Entrer votre email", labelText: "Email"),
          //           // ),
          //           // TextFormField(
          //           //   obscureText: true,
          //           //   onChanged: (e) => pass = e,
          //           //   validator: (e) => e.isEmpty
          //           //       ? "Champ vide"
          //           //       : e.length < 6
          //           //           ? "le password doit être plus de 6"
          //           //           : null,
          //           //   decoration: InputDecoration(
          //           //       hintText: "*****************", labelText: "Password"),
          //           // ),
          //           SizedBox(
          //             height: 10,
          //           ),
          // FlatButton(
          //   child: Text("Forgot your password ?",
          //       style: TextStyle(color: Colors.lightBlue)),
          //   onPressed: () {
          //     Routes.resetPasswordScreenNavigator(context);
          //     // Navigator.of(context).push(
          //     //     MaterialPageRoute(builder: (ctx) => ResetPassword()));
          //   },
          // ),
          // RaisedButton(
          //   onPressed: () async {
          //     if (keys.currentState.validate()) {
          //       loading(context);
          //       print(_email.text + "    " + _password.text);
          //       bool login =
          //           await auth.signin(_email.text, _password.text);
          //       if (login != null) {
          //         setState(() {
          //           Navigator.of(context).pop();
          //         });
          //         Routes.statutAuthNavigator(context);
          //         if (!login) print("Incorrect email or password");
          //       }
          //     }
          //   },
          //   child: Text("Sign In"),
          // ),
          //           SizedBox(height: 15),
          //           // Row(
          //           //   mainAxisAlignment: MainAxisAlignment.center,
          //           //   children: [
          //           //     FlatButton.icon(
          //           //       shape: RoundedRectangleBorder(
          //           //           borderRadius: BorderRadius.circular(20)),
          //           //       color: Colors.redAccent,
          //           //       onPressed: () async {
          //           //         loading(context);
          //           //         bool googleSignIn = await auth.googleSignIn();
          //           //         if (googleSignIn != null) Navigator.of(context).pop();
          //           //       },
          //           //       label: Text(
          //           //         "Google",
          //           //         style: style.copyWith(
          //           //           fontSize: 18,
          //           //           color: Colors.white,
          //           //         ),
          //           //       ),
          //           //       icon: Icon(FontAwesomeIcons.google,
          //           //           size: 20, color: Colors.white),
          //           //     ),
          //           //     Container(
          //           //       width: 15,
          //           //     ),
          //           //     FlatButton.icon(
          //           //       shape: RoundedRectangleBorder(
          //           //           borderRadius: BorderRadius.circular(20)),
          //           //       color: Colors.blueAccent,
          //           //       onPressed: () async {},
          //           //       label: Text(
          //           //         "Facebook",
          //           //         style:
          //           //             style.copyWith(fontSize: 18, color: Colors.white),
          //           //       ),
          //           //       icon: Icon(FontAwesomeIcons.facebookF,
          //           //           size: 20, color: Colors.white),
          //           //     ),
          //           //   ],
          //           // ),
          //           // SizedBox(height: 15),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Do you have an account ?"),
          //     FlatButton(
          //         onPressed: () {
          //           Routes.signinScreenNavigator(context);
          //         },
          //         child: Text("register"))
          //   ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // )),
        ),
      ],
    );
  }
}

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();
//   // String _email;
//   // String _password;
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
//           // onChanged: (value) => _email = value,
//           controller: _email,
//           // onSaved: (String value) {
//           //   _email = value;
//           // },
//         ),
//       ),
//     );
//   }

//   // Initially password is obscure
//   bool obscureText = true;

//   // Toggles the password show status
//   void _toggle() {
//     setState(() {
//       obscureText = !obscureText;
//     });
//   }

//   Widget _buildPassword() {
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
//             hintText: 'Mot de passe',
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Icon(
//                 FontAwesomeIcons.userLock,
//                 color: Colors.white,
//                 // size: 30,
//                 size: 25,
//               ),
//             ),
//           ),
//           keyboardType: TextInputType.visiblePassword,
//           validator: (String value) {
//             if (value.isEmpty) {
//               return "Le champs mdp est requis";
//             } else if (value.length < 8) {
//               return "Le mot de passe doit comporter au moins 8 caractères";
//             }

//             return null;
//           },
//           // onSaved: (value) => _password = value,
//           controller: _password,
//           obscureText: obscureText,
//           // onSaved: (String value) {
//           //   _password = value;
//           // },
//         ),
//       ),
//     );

//     // IconButton(
//     //   onPressed: _toggle,
//     //   icon: FaIcon(obscureText ? FontAwesomeIcons.eye: FontAwesomeIcons.eyeSlash),
//     // ),],
//     // );
//   }

//   AuthService auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         BackgroundImage(),
//         // ShaderMask(
//         //   shaderCallback: (bounds) => LinearGradient(
//         //     colors: [Colors.black12, Colors.black12],
//         //     begin: Alignment.bottomCenter,
//         //     end: Alignment.center,
//         //   ).createShader(bounds),
//         //   blendMode: BlendMode.darken,
//         //   child: Container(
//         //     decoration: BoxDecoration(
//         //       image: DecorationImage(
//         //         image: AssetImage('assets/5448485.png'),
//         //         fit: BoxFit.cover,
//         //         colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           // appBar: AppBar(
//           //   title: Text(
//           //     "INSCRIPTION",
//           //     style: GoogleFonts.montserrat(letterSpacing: 1.0),
//           //   ),
//           //   backgroundColor: Colors.blueAccent,
//           //   automaticallyImplyLeading: false,
//           // ),
//           body: SingleChildScrollView(
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 150,
//                     child: Center(
//                       child: Text(
//                         'Angel Dress',
//                         style: kHeading,
//                       ),
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 20,
//                   // ),
//                   Container(
//                     margin: EdgeInsets.all(24),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           _buildEmail(),
//                           _buildPassword(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(child: Text("Mot de passe oublié ?", style: TextStyle(color: Colors.white),), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen())),)
//                             ],
//                           ),
//                           // SizedBox(height: 100),
//                           // ButtonTheme(
//                           //   minWidth: 300.0,
//                           //   buttonColor: Colors.blueAccent,
//                           //   child: RaisedButton(
//                           //     child: Text(
//                           //       "SE CONNECTER",
//                           //       style: GoogleFonts.montserrat(
//                           //           color: Colors.white,
//                           //           fontSize: 16,
//                           //           letterSpacing: 2.0),
//                           //     ),
//                           //   ),
//                           // )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 7,
//                         ),
//                         new RoundedButton(
//                           buttonText: 'Se connecter',
//                           onPressed: () async {
//                             print("btn click");
//                             if (_formKey.currentState.validate()) {
//                               loading(context);
//                               print(_password);
//                               // print(_email + _password);
//                               bool login = await auth.signIn(
//                                   this._email.text, this._password.text);
//                               if (login != null) {
//                                 Navigator.of(context).pop();
//                                 if (!login)
//                                   print("email ou mot de passe incorrecte");
//                               }
//                             }

//                             _formKey.currentState.save();

//                             print(this._email.text);
//                             print(this._password.text);
//                             // if (_formKey.currentState.validate()) {
//                             //   // Affiche le Snackbar si le formulaire est valide
//                             //   Scaffold.of(context).showSnackBar(
//                             //       SnackBar(content: Text('Traitement en cours')));
//                             // }
//                             //Send to API
//                           },
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(color: Colors.white, width: 1),
//                             ),
//                           ),
//                           child: FlatButton(
//                               child: Text(
//                                 'Creer un compte',
//                                 style: kBodyText,
//                               ),
//                               onPressed: () =>
//                               Routes.signinScreenNavigator(context),
//                               // duration: Duration(milliseconds: 300),
//                               // curve: Curves.easeIn),
//                               ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         DotDivider(),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             // ElevatedButton.icon(
//                             //   onPressed: null, label: Text("Commander", style: GoogleFonts.montserrat(
//                             //     color: Colors.red
//                             // ),),icon: Icon( FontAwesomeIcons.shoppingBag, color: Colors.white,), ),
//                             // ApiRowButton(
//                             //   ApiButtonColor: Colors.red,
//                             //   buttonText: "GOOGLE",
//                             //   onPressed: () {
//                             //     print("google");
//                             //     // await AuthService().SignInWithGoogle().then((UserCredential value){
//                             //     //   final displayName = value.user.displayName;
//                             //     //
//                             //     //   print(displayName);
//                             //     //
//                             //     //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
//                             //     // });
//                             //     // loading(context);
//                             //     final provider =
//                             //         Provider.of<GoogleSignInProvider>(context,
//                             //             listen: false);
//                             //     provider.login();
//                             //   },
//                             //   icon: Icon(
//                             //     FontAwesomeIcons.google,
//                             //     color: Colors.white,
//                             //   ),
//                             // ),
//                             // ApiRowButton(
//                             //   ApiButtonColor: Colors.blueAccent,
//                             //   buttonText: "FACEBOOK",
//                             //   onPressed: () async {
//                             //     // loading(context);
//                             //     print("facebook");
//                             //    await LoginWithFacebook().handleLogin();
//                             //     // if (LoginWithFacebook().handleLogin() != null) {
//                             //     //   Navigator.of(context).pop();
//                             //     //   if (!LoginWithFacebook().handleLogin())
//                             //     //     print("Network error please retry later");
//                             //     // }
//                             //     // final login = await logg().loginWithFB();
//                             //     // print("--------------$login----------");
//                             //     // if (logg().isLoggedIn = true) {
//                             //     //   Navigator.push(
//                             //     //     context,
//                             //     //     MaterialPageRoute(
//                             //     //       builder: (BuildContext context) {
//                             //     //         return HomePage();
//                             //     //       },
//                             //     //     ),
//                             //     //   );
//                             //       // Navigator.of(context).pop();
//                             //     //   if (!login)
//                             //     //     print("email ou mot de passe incorrecte");
//                             //     // };
//                             //     // LoginWithFacebook();
//                             //     print("yes");
//                             //   },
//                             //   icon: Icon(
//                             //     FontAwesomeIcons.facebook,
//                             //     color: Colors.white,
//                             //   ),
//                             // ),
//                             // Text("GOOGLE",
//                             //   style: kBodyText,
//                             // ),
//                             // Text("FACEBOOK",
//                             //   style: kBodyText,
//                             // ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();
//   // String _email;
//   // String _password;
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
//         ),
//       ),
//     );
//   }

//   // Initially password is obscure
//   bool obscureText = true;

//   // Toggles the password show status
//   void _toggle() {
//     setState(() {
//       obscureText = !obscureText;
//     });
//   }

//   Widget _buildPassword() {
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
//             hintText: 'Mot de passe',
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Icon(
//                 FontAwesomeIcons.userLock,
//                 color: Colors.white,
//                 // size: 30,
//                 size: 25,
//               ),
//             ),
//           ),
//           keyboardType: TextInputType.visiblePassword,
//           validator: (String value) {
//             if (value.isEmpty) {
//               return "Le champs mdp est requis";
//             } else if (value.length < 8) {
//               return "Le mot de passe doit comporter au moins 8 caractères";
//             }

//             return null;
//           },
//           controller: _password,
//           obscureText: obscureText,
//           // },
//         ),
//       ),
//     );

//   }

//   AuthService auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         BackgroundImage(),
//         // ShaderMask(
//         //   shaderCallback: (bounds) => LinearGradient(
//         //     colors: [Colors.black12, Colors.black12],
//         //     begin: Alignment.bottomCenter,
//         //     end: Alignment.center,
//         //   ).createShader(bounds),
//         //   blendMode: BlendMode.darken,
//         //   child: Container(
//         //     decoration: BoxDecoration(
//         //       image: DecorationImage(
//         //         image: AssetImage('assets/5448485.png'),
//         //         fit: BoxFit.cover,
//         //         colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           // appBar: AppBar(
//           //   title: Text(
//           //     "INSCRIPTION",
//           //     style: GoogleFonts.montserrat(letterSpacing: 1.0),
//           //   ),
//           //   backgroundColor: Colors.blueAccent,
//           //   automaticallyImplyLeading: false,
//           // ),
//           body: SingleChildScrollView(
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 150,
//                     child: Center(
//                       child: Text(
//                         'ParkLine',
//                         style: kHeading,
//                       ),
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 20,
//                   // ),
//                   Container(
//                     margin: EdgeInsets.all(24),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           _buildEmail(),
//                           _buildPassword(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(child: Text("Mot de passe oublié ?", style: TextStyle(color: Colors.white),), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen())),)
//                             ],
//                           ),
//                           // SizedBox(height: 100),
//                           // ButtonTheme(
//                           //   minWidth: 300.0,
//                           //   buttonColor: Colors.blueAccent,
//                           //   child: RaisedButton(
//                           //     child: Text(
//                           //       "SE CONNECTER",
//                           //       style: GoogleFonts.montserrat(
//                           //           color: Colors.white,
//                           //           fontSize: 16,
//                           //           letterSpacing: 2.0),
//                           //     ),
//                           //   ),
//                           // )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 7,
//                         ),
//                         new RoundedButton(
//                           buttonText: 'Se connecter',
//                           onPressed: () async {
//                             print("btn click");
//                             if (_formKey.currentState.validate()) {
//                               loading(context);
//                               print(_email.text);
//                               print(_password);
//                               // print(_email + _password);
//                               bool login = await auth.signIn(
//                                   this._email.text, this._password.text);
//                               if (login != null) {
//                                 Navigator.of(context).pop();
//                                 if (!login)
//                                   print("email ou mot de passe incorrecte");
//                               }
//                             }

//                             _formKey.currentState.save();

//                             print(this._email.text);
//                             print(this._password.text);
//                             // if (_formKey.currentState.validate()) {
//                             //   // Affiche le Snackbar si le formulaire est valide
//                             //   Scaffold.of(context).showSnackBar(
//                             //       SnackBar(content: Text('Traitement en cours')));
//                             // }
//                             //Send to API
//                           },
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(color: Colors.white, width: 1),
//                             ),
//                           ),
//                           child: FlatButton(
//                               child: Text(
//                                 'Creer un compte',
//                                 style: kBodyText,
//                               ),
//                               onPressed: () =>
//                                   Routes.signinScreenNavigator(context)
//                               // duration: Duration(milliseconds: 300),
//                               // curve: Curves.easeIn),
//                               ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
