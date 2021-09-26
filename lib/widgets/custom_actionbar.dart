import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice/screens/cart_page.dart';

import '../firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasTitle;
  final bool hasBackArrow;

  CustomActionBar({this.hasBackArrow, this.title, this.hasTitle});
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 35, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 32,
                width: 32,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title,
              style: Constants.boldHeading,
            ),
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.shoppingCart,
                      color: Color(0xffFF7466),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    StreamBuilder(
                        stream: _firebaseServices.usersRef
                            .doc(_firebaseServices.getUserId())
                            .collection("Cart")
                            .snapshots(),
                        builder: (context, snapshot) {
                          int _totalItems = 0;

                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            List _documents = snapshot.data.docs;
                            _totalItems = _documents.length;
                          }
                          return Text(
                            '${_totalItems}' ?? '0',
                            style: TextStyle(
                                color: Color(0xffFF7466),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          );
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
