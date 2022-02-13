import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Const/const.dart';
import 'package:parkline/Services/auth_service.dart';
import 'package:parkline/Widgets/loading.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _username = TextEditingController();
  // TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();
  AuthServices auth = AuthServices();
  String email, pass, cpass, pseu;
  final keys = GlobalKey<FormState>();

  Widget _builUsername() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          // maxLength: 15,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Username",
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.userAlt,
                color: Colors.white,
                // size: 30,
                size: 25,
              ),
            ),
          ),
          keyboardType: TextInputType.url,
          validator: (String value) {
            if (value.isEmpty) {
              return "Username is required";
            }

            return null;
          },
          controller: _username,
          // onChanged: (value) => _username = value,
          // onSaved: (String value) {
          //   _username = value;
          // },
        ),
      ),
    );
  }

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
          controller: _email,
          // onChanged: (value) => _email = value,
          // onSaved: (String value) {
          //   _email = value;
          // },
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return
        // Column(
        // children: [
        Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          // maxLength: 15,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Password",
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
          controller: _password,
          // onSaved: (value) => _password = value,
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

  Widget _buildCPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          // maxLength: 15,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Confirm Password",
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.lock,
                color: Colors.white,
                // size: 30,
                size: 25,
              ),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (String value) {
            if (value.isEmpty) return 'Please confirm your password';
            if (value != _password.text) return "Please check your password";
            return null;
          },
          controller: _cpassword,
          // onChanged: (value) => _cpassword = value,
          obscureText: obscureText,
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
                    height: 150,
                    child: Center(
                      child: Text(
                        'REGISTER',
                        style: kHeading,
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  //   child: Text(
                  //     "Inscrivez vous pour acceder au notre catalogue de produit",
                  //     style: smallkBodyText,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.all(24),
                    child: Form(
                      key: keys,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _builUsername(),
                          _buildEmail(),
                          _buildPassword(),
                          _buildCPassword(),
                          // SizedBox(height: 100),
                          // ButtonTheme(
                          //   minWidth: 300.0,
                          //   buttonColor: Colors.blueAccent,
                          //
                          //   child: RaisedButton(
                          //     child: Text(
                          //       "S'INSCRIRE",
                          //       style: GoogleFonts.montserrat(
                          //           color: Colors.white,
                          //           fontSize: 16,
                          //           letterSpacing: 2.0),
                          //     ),
                          //     onPressed: () async {
                          //       if (_formKey.currentState.validate()) {
                          //         print(_email + _password);
                          //         bool register = await auth.signUp(
                          //             _email, _name, _username, _password);
                          //         if (register) Navigator.of(context).pop();
                          //       }
                          //
                          //       _formKey.currentState.save();
                          //
                          //       print(_name);
                          //       print(_email);
                          //       print(_username);
                          //       print(_phoneNumber);
                          //       print(_password);
                          //       print(_cpassword);
                          //       // if (_formKey.currentState.validate()) {
                          //       //   // Affiche le Snackbar si le formulaire est valide
                          //       //   Scaffold.of(context).showSnackBar(
                          //       //       SnackBar(content: Text('Traitement en cours')));
                          //       // }
                          //       //Send to API
                          //     },
                          //   ),
                          // ),

                          Column(
                            children: [
                              SizedBox(
                                height: 30,
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
                                      // print(_email.text +
                                      //     "    " +
                                      //     _password.text);
                                      bool register = await auth.signup(
                                          _email.text,
                                          _password.text,
                                          _username.text);
                                      if (register != false) {
                                        if (register != null) {
                                          Navigator.of(context).pop();
                                        }
                                        Routes.statutAuthNavigator(context);
                                      }
                                      if (!register)
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Text(
                                      "Sign Up",
                                      style: kBodyText,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   border: Border(
                                //     bottom: BorderSide(
                                //         color: Colors.white, width: 1),
                                //   ),
                                // ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Do you have an account ?",
                                      style: TextStyle(color: kblack),
                                    ),
                                    FlatButton(
                                        onPressed: () {
                                          Routes.loginScreenNavigator(context);
                                        },
                                        child: Text("login",
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
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
