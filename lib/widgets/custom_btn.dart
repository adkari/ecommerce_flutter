import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isloading;
  CustomBtn({this.text, this.onPressed, this.isloading});

  @override
  Widget build(BuildContext context) {
    bool _isloading = isloading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xff223943),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xff223943),
            width: 2,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Visibility(
              visible: _isloading ? false : true,
              child: Center(
                child: Text(
                  text ?? '..Text',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
            Visibility(
              visible: _isloading,
              child: Center(
                  child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }
}
