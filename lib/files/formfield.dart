import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class customtextfield extends StatelessWidget {
  dynamic Function(String) onSaved;
  final String regEx;
  final String hinttext;
  final String errormssg;
  final bool obscure;
  customtextfield({
    required this.obscure,
    required this.errormssg,
    required this.onSaved,
    required this.regEx,
    required this.hinttext,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),
        onSaved: (_value) => onSaved(_value!),
        validator: (_value1) {
          return RegExp(regEx).hasMatch(_value1!) ? null : errormssg;
        },
      ),
    );
  }
}
