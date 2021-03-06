// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// Project imports:
import '../brand_Category.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categories =
        FirebaseFirestore.instance.collection('Categories').snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "categories1".tr,
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
         borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[_productBox(index)]),
      ),
    );
  }

  Widget _productBox(int index) {
    return Container(
        height: 95,
      //  padding: const EdgeInsets.all(2.0),
        // width: 100,
        margin: EdgeInsets.all(2.0),
        child: Row(
          
          children: [
            SizedBox(width: 20),
          Container(
          alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            //  color: Colors.white,
            ),
            height: 110,
            width: 110,
            
            child:Text(
                          data.docs[index]['name'],
                          style: GoogleFonts.adamina(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
          ),
          SizedBox(width: 16),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 5),
             Container(
               alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            //  color: Colors.white,
      ),
            height: 90,
            width: 90,
               child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  data.docs[index]['image'],
                ),
            ),
             ),
                      ]))),
        ]));
  }
}
