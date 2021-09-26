import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool ispassword;
  CustomInput(
      {this.hintText,
      this.focusNode,
      this.onChanged,
      this.onSubmitted,
      this.textInputAction,
      this.ispassword});
  @override
  Widget build(BuildContext context) {
    bool _ispassword = ispassword ?? false;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
      ),
      child: TextField(
        textInputAction: textInputAction,
        focusNode: focusNode,
        obscureText: _ispassword,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: TextStyle(color: Colors.blueGrey),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? '..HintText',
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
