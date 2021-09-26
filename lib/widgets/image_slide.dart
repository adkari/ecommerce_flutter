import 'package:flutter/material.dart';

class ImageSlide extends StatefulWidget {
  final List imageList;
  ImageSlide({this.imageList});
  @override
  _ImageSlideState createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  int _selectedpage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 3.5,
            child: PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedpage = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                    child: Image.network(
                      '${widget.imageList[i]}',
                      alignment: Alignment.center,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  height: 5,
                  width: _selectedpage == i ? 10 : 5,
                  decoration: BoxDecoration(
                      color: Colors.black38.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30)),
                )
            ],
          )
        ],
      ),
    );
  }
}
