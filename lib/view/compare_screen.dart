import 'package:brandz/model/product_model.dart';
import 'package:brandz/view/category_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/cart_controller.dart';
import '../model/list_of_products.dart';
import '../model/user_model.dart';

class ComparePage extends StatefulWidget {
  static List<Product> productInComparison = []; // list to store products

  ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => _ComparePageState(productInComparison);
}

/* 
// add logic
if (!isEmpty) {
 if (!isFull) {  
  if(p1.cate == p2.cate){ // edit later
  // add & set isFull to true 
  }//reject.  Display (can't compare 2 product not in same cate) 
 }// reject. Display (camparison is Full)
}// add no product in comparison & set isEmpty to false
 */

class _ComparePageState extends State<ComparePage> {
  List<Product> productInComparison;
  final _auth = FirebaseAuth.instance;
  int pressed1 = 0;
  int pressed2 = 0;

  _ComparePageState(this.productInComparison);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: BackButton(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Products Comparison',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  clearFromCompare();
                  print('cleared!');
                  setState(() {});
                },
                child: Text(
                  'Clear',
                  style: GoogleFonts.adamina(color: Colors.black, fontSize: 15),
                )),
          ],
        ),
        body: productInComparison.length == 0
            ? emptyComparison() // case 1
            : productInComparison.length == 1
                ? columnOfRPNI() // case 2 one product in comparison
                :
                // case 3 compare 2 products
                Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          columnOfRPNI2(0),
                          Column(
                            children: [
                              SizedBox(
                                height: 75,
                              ),
                              Center(
                                  child: Text(
                                'Products',
                                style: GoogleFonts.adamina(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black),
                              ))
                            ],
                          ),
                          columnOfRPNI2(1)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () async {
                              bool found = false;
                              User? user = _auth.currentUser;

                              var object = productInComparison[0];
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('Cart')
                                  .get()
                                  .then((querySnapshot) async {
                                querySnapshot.docs.forEach((doc) {
                                  if (doc.data()['productImage'] ==
                                      object.imageURL) {
                                    found = true;
                                  }
                                });
                                if (found == true) {
                                  return;
                                } else {
                                  if (pressed1 == 0) AddToCart(object, user);
                                  ++pressed1;
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
                          SizedBox(
                            width: 30,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () async {
                              bool found = false;
                              User? user = _auth.currentUser;

                              var object = productInComparison[1];
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('Cart')
                                  .get()
                                  .then((querySnapshot) async {
                                querySnapshot.docs.forEach((doc) {
                                  if (doc.data()['productImage'] ==
                                      object.imageURL) {
                                    found = true;
                                  }
                                });
                                if (found == true) {
                                  return;
                                } else {
                                  if (pressed2 == 0) AddToCart(object, user);
                                  ++pressed2;
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
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(productInComparison[0].price.toString() +
                                    ' SAR'),
                                Center(
                                    child: Text(
                                  'Price',
                                  style: GoogleFonts.adamina(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                )),
                                Text(productInComparison[1].price.toString() +
                                    ' SAR')
                              ],
                            ),
                            // price
                            Divider(
                              endIndent: 30,
                              indent: 30,
                              height: 30,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /* Text(
                                    '150 ml'), */
                                Text(
                                    productInComparison[0].size), // update late
                                Center(
                                    child: Text(
                                  'Size',
                                  style: GoogleFonts.adamina(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                )),
                                /* Text(
                                    '150 ml') */
                                Text(productInComparison[1]
                                    .size) //  update later
                              ],
                            ), //size
                            Divider(
                              endIndent: 30,
                              indent: 30,
                              height: 30,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(productInComparison[0].brandName),
                                Center(
                                    child: Text(
                                  'Brand',
                                  style: GoogleFonts.adamina(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                )),
                                Text(productInComparison[1].brandName)
                              ],
                            ), // brand
                            Divider(
                              endIndent: 30,
                              indent: 30,
                              height: 30,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            // Details Start here
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      productInComparison[0].description,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Details',
                                  style: GoogleFonts.adamina(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      productInComparison[1].description,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                    ),
                                  ),
                                )
                              ],
                            ), // Details End here
                          ],
                        ),
                      )
                    ],
                  ));
  }

  Column columnOfRPNI2(int index) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                FlatButton(
                    onPressed: () {
                      if (!productInComparison.isEmpty) {
                        print(productInComparison[index].name);
                        removeFromCompare(index);
                        setState(() {});
                      }
                    },
                    child: Text(
                      'Remove Product',
                      style: GoogleFonts.adamina(
                          textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(88, 0, 0, 0)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    productInComparison[index].name,
                    style: GoogleFonts.adamina(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8), // Border width
                  decoration: BoxDecoration(
                      color: Color.fromARGB(88, 0, 0, 0),
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: Image.network(productInComparison[index].imageURL,
                          fit: BoxFit.cover),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Column columnOfRPNI() {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                FlatButton(
                    onPressed: () {
                      if (!productInComparison.isEmpty) {
                        print(productInComparison[0].name);
                        removeFromCompare(0);
                        setState(() {});
                      }
                    },
                    child: Text(
                      'Remove Product',
                      style: GoogleFonts.adamina(
                          textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(88, 0, 0, 0)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    productInComparison[0].name,
                    style: GoogleFonts.adamina(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8), // Border width
                  decoration: BoxDecoration(
                      color: Color.fromARGB(88, 0, 0, 0),
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: Image.network(productInComparison[0].imageURL,
                          fit: BoxFit.cover),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 169,
            ),
            Center(
                child: Column(
              children: [
                Text(
                  'Add Another Product To Compare With',
                  style: GoogleFonts.adamina(fontSize: 12, color: Colors.black),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                  },
                  child: Text(
                    "View Products Category",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                ),
              ],
            ))
          ],
        )
      ],
    );
  }

  void removeFromCompare(int index) {
    productInComparison.removeAt(index);
  }

  void clearFromCompare() {
    int count = productInComparison.length;
    print('count=$count');
    if (count == 0) {
      print('compere is empty!');
      return;
    }
    for (int i = 0; i < count; i++) {
      removeFromCompare(0); // because after removing list item will be shifed
    }
  }

  void AddToCart(Product product, User? user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Cart')
          .add({
        'productName': product.name,
        'productImage': product.imageURL,
        'productPrice': product.price,
        'productBrandName': product.brandName,
        'productQuantity': product.quantitiy,
        'productDescription': product.description,
        'productSize': product.size
      });
    } catch (e) {}
  }
}

class emptyComparison extends StatelessWidget {
  const emptyComparison({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No Products To Compare With',
          style: GoogleFonts.adamina(fontSize: 12, color: Colors.black),
        ),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()),
            );
          },
          child: Text(
            "View Products Category",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ),
      ],
    ));
  }
}
