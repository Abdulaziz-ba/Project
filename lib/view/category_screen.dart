import 'package:brandz/brand_Category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constats.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categories =
        FirebaseFirestore.instance.collection('Categories').snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: categories,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("");
              }
              if (snapshot.hasError) {
                return Text("");
              }
              final data = snapshot.requireData;
              return Container(
                  child: ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return CartProductsCard(data: data, index: index);
                      }));
            }));
  }
}

class CartProductsCard extends StatelessWidget {
//  final CartController controller;
  final int index;
  final QuerySnapshot<Object?> data;
  static double total = 0;
  int number = 1;
  CartProductsCard({required this.data, required this.index});
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        String displayCategory = data.docs[index]['name'].toString();
        FirebaseFirestore.instance
            .collection("Categories")
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (doc.data()['name'] == displayCategory) {
              var id = doc.id; // randomly generated document ID
              var data = doc.data();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BrandzCategory(
                          id: id,
                        )),
              );
            }
          });
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[_productBox(index)]),
      ),
    );
  }

  Widget _productBox(int index) {
    return Container(
        height: 95,
        padding: const EdgeInsets.all(8.0),
        // width: 100,
        margin: EdgeInsets.all(4.0),
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            height: 110,
            width: 110,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                data.docs[index]['image'],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          data.docs[index]['name'],
                          style: GoogleFonts.adamina(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ]))),
          Icon(Icons.arrow_forward)
        ]));
  }
}