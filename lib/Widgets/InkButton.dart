import 'package:flutter/material.dart';
import 'package:parkline/Const/const.dart';

class InkButton extends StatelessWidget {

  const InkButton(
      {Key key,
      @required this.tapMethod,
      @required this.textButton,
      @required this.iconButton})
      : super(key: key);

 final String textButton;
 final  tapMethod;
 final Icon iconButton;


  @override
  Widget build(BuildContext context) {
  bool isOk = false;
    return InkWell(
      onTap: tapMethod,
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10.0)),
          child: isOk == false
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, 
              children: [
                  Text(
                    '$textButton',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                          color: kwhite,
                          fontSize: 20.0),
                    ),
                  SizedBox(
                    width: 15.0,
                  ),
                  iconButton,
                  // Icon(
                  //   iconButton,
                  //   color: kwhite,
                  // )
                ])
              : Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "PLEASE WAIT",
                    style: TextStyle(fontSize: 16.0, color: kwhite),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                ])),
    );
  }
}
