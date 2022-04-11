
import 'package:brandz/product_brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:brandz/product_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:brandz/controller/cart_controller.dart";
import 'package:google_fonts/google_fonts.dart';
import 'model/product_model.dart';
import 'model/user_model.dart';
import 'package:brandz/view/auth/login_screen.dart';

class product_page extends StatelessWidget {
  String id;
  final _auth = FirebaseAuth.instance;
  int pressed = 0;
  final cartController = Get.put(CartController());

  product_page({required this.id});

  @override
  Widget build(BuildContext context) {
    final productData =
        FirebaseFirestore.instance.collection('Products').doc(id).snapshots();
    return Container(
      child: StreamBuilder(
        stream: productData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("");
          }
          if (snapshot.hasError) {
            return Text("");
          }
          DocumentSnapshot<Object?> data = snapshot.requireData;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Product Details ',
                style: GoogleFonts.adamina(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white10,
              leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              elevation: 0.0,
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(data["image"]),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Product Name Field
                            Text(
                              data["name"],
                              // "Perfume",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Product Price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data["price"] + " SAR",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "About Products",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              data["description"],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 170,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    onPressed: () async {
                                      print('hello');
                                      bool found = false;
                                      User? user = _auth.currentUser;
                                      UserModel userModel = UserModel();
                                      String Brand = data['name'].toString();
                                      var noteInfo = data!.data()! as Map;
                                      var object = Product(
                                          imageURL: noteInfo['image'],
                                          name: noteInfo['name'],
                                          price:
                                              double.parse(noteInfo['price']),
                                          brandName: noteInfo['BrandName'],
                                          quantitiy: 1,
                                          description: noteInfo['description']);
                                      await FirebaseFirestore.instance
                                          .collection("Cart")
                                          .doc(CartController.id)
                                          .collection('Products')
                                          .get()
                                          .then((querySnapshot) async {
                                        querySnapshot.docs.forEach((doc) {
                                          print(doc.data()['productImage'] ==
                                              noteInfo['image']);
                                          if (doc.data()['productImage'] ==
                                              noteInfo['image']) {
                                            found = true;
                                          }
                                        });
                                        if (found == true) {
                                          return;
                                        } else {
                                          if (pressed == 0)
                                            cartController.addProduct(
                                                object, user);
                                          ++pressed;
                                          return;
                                        }
                                        ;
                                      });
                                    },
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    onPressed: () {},
                                    color: Colors.red,
                                    child: Text(
                                      "Add to Favorite",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}