import 'package:flutter/material.dart';

class ProductColor extends StatefulWidget {
  final List productColor;
  final Function(String) onSelected;
  ProductColor({this.productColor, this.onSelected});

  @override
  _ProductColorState createState() => _ProductColorState();
}

class _ProductColorState extends State<ProductColor> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          for (var i = 0; i < widget.productColor.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected('${widget.productColor[i]}');
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                //height: 40,
                decoration: BoxDecoration(
                  color: _selected == i ? Color(0xffF6E9D9) : Color(0xffEEEAE1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '${widget.productColor[i]}',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _selected == i ? Color(0xffFF7466) : Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
