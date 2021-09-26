import 'package:flutter/material.dart';
import 'package:practice/widgets/custom_actionbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/widgets/product_card.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.only(
                      top: 100.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductCard(
                        title: document['name'],
                        imageUrl: document['images'][0],
                        price: "\$ ${document['price']}",
                        productId: document.id,
                      );
                    }).toList(),
                  ),
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
            hasBackArrow: false,
            title: 'Home',
            hasTitle: true,
          ),
        ],
      ),
    );
  }
}
