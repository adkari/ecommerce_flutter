import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice/constants.dart';
import 'package:practice/widgets/custom_actionbar.dart';
import 'package:practice/widgets/image_slide.dart';
import 'package:practice/widgets/product_color.dart';

import '../firebase_services.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedColor = '0';

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"Color": _selectedColor});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text('Product added to cart'),
    backgroundColor: Color(0xffFF7466).withOpacity(0.7),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                // List of images
                List imageList = documentData['images'];
                List productColor = documentData['color'];

                _selectedColor = productColor[0];

                return ListView(
                  children: [
                    ImageSlide(
                      imageList: imageList,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text(
                        '${documentData['name']}',
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text(
                        '\$ ${documentData['price']}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffFF7466),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        '${documentData['desc']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        'Select a Color',
                        style: Constants.regularDarkText,
                      ),
                    ),
                    ProductColor(
                      productColor: productColor,
                      onSelected: (color) {
                        _selectedColor = color;
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffEEEAE1),
                                borderRadius: BorderRadius.circular(12)),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16),
                              child: Image(
                                image: AssetImage('assets/tab_saved.png'),
                                height: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFF7466),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
          ),
        ],
      ),
    );
  }
}
