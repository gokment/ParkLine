import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({Key key, @required fieldValue, @required hintText, @required iconChild}) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

  TextEditingController fieldValue = TextEditingController();
class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
          decoration: BoxDecoration(
            // color: Colors.grey[600].withOpacity(0.4),
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              border: InputBorder.none,
              hintText: 'Search',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.blueAccent,
                  // size: 30,
                  size: 25,
                ),
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Require text field*';
              }

              return null;
            },
            controller: fieldValue,
          )),
    );
  }
}
