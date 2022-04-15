import 'package:brandz/model/product_model.dart';
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
  static List<Product> productInComparison = [];

  //static int itemsInComp = 0;
  static ValueNotifier<bool> valueNotifier = ValueNotifier(false);

  ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() =>
      _ComparePageState(valueNotifier, productInComparison);
}

/* 
// add logic
if (!isEmpty) {
 if (!isFull) {  
  if(p1.cate == p2.cate){
  // add & set isFull to true 
  }//reject.  Display (can't compare 2 product not in same cate) 
 }// reject. Display (camparison is Full)
}// add no product in comparison & set isEmpty to false
 */

class _ComparePageState extends State<ComparePage> {
  List<Product> productInComparison;
  final _auth = FirebaseAuth.instance;
  final cartController = Get.put(CartController());

  int pressed1 = 0;
  int pressed2 = 0;

  //bool isFull = false; // 2 product // productInComparison.length == 2
  //bool isEmpty = true; // 0 product //productInComparison.isEmpty
  //int itemCount = 0; // keep count of product
  ValueNotifier<bool> valueNotifier;
  _ComparePageState(this.valueNotifier, this.productInComparison);

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
                  //valueNotifier = ValueNotifier(false);
                  //Provider.of(context, listen: false);
                  print('cleared!');
                  setState(() {});
                  /*     Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => this.build(context))); */
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
                //Text(productInComparison[0].name)
                : /* Column(
                    children: [
                      Text(productInComparison[0].name),
                      Text(productInComparison[1].name)
                    ],
                  ) */
                // case 3 compare 2 products
                Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          columnOfRPNI2(0), //Column(),
                          Column(
                            children: [Center(child: Text('Products'))],
                          ),
                          columnOfRPNI2(1) //Column()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () async {
                              bool found = false;
                              User? user = _auth.currentUser;

                              var object = productInComparison[0];
                              await FirebaseFirestore.instance
                                  .collection("Cart")
                                  .doc(CartController.id)
                                  .collection('Products')
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
                                  if (pressed1 == 0)
                                    cartController.addProduct(object, user);
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
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () async {
                              bool found = false;
                              User? user = _auth.currentUser;

                              var object = productInComparison[1];
                              await FirebaseFirestore.instance
                                  .collection("Cart")
                                  .doc(CartController.id)
                                  .collection('Products')
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
                                  if (pressed2 == 0)
                                    cartController.addProduct(object, user);
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
                      //Container(
                      //color: Colors.lightBlue,
                      //  child: Row(
                      // children: [
                      Container(
                        //color: Colors.lightBlueAccent,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(productInComparison[0].price.toString() +
                                    ' SAR'),
                                Text('Price'),
                                Text(productInComparison[1].price.toString() +
                                    ' SAR')
                              ],
                            ),
                            // price
                            Divider(
                              // endIndent: 30,
                              //height: 100,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    productInComparison[0].size), //Text(productInComparison[0].size),
                                Text('Size'),
                                Text(
                                    productInComparison[1].size) //Text(productInComparison[1].size)
                              ],
                            ), //size
                            Divider(
                              //endIndent: 30,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(productInComparison[0].brandName),
                                Text('Brand'),
                                Text(productInComparison[1].brandName)
                              ],
                            ), // brand
                            Divider(
                              //endIndent: 30,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                        productInComparison[0].description)),
                                Text('Details'),
                                Expanded(
                                    child: Text(
                                        productInComparison[1].description))
                              ],
                            ), // details
                          ],
                        ),
                      )
                    ],
                    //  ),
                    //)
                    // ],
                  )

        //Only1Product()

        /* Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                      // poduct 1
                      onPressed: () {
                        /*  if (!productInComparison.isEmpty)
                    for (var product in productInComparison)
                      print(product.name);
                  print(productInComparison.length); */
                        if (!productInComparison.isEmpty) {
                          print(productInComparison[0].name);
                          removeFromCompare(0);
                        }
                      },
                      child: Text('000000000000000')),
                  FlatButton(
                      // product 2
                      onPressed: () {
                        if (!productInComparison.isEmpty) {
                          if (productInComparison.length == 2) {
                            print(productInComparison[1].name);
                            removeFromCompare(1);
                          } else {
                            print(productInComparison[0].name);
                            removeFromCompare(0);
                          }
                        }
                      },
                      child: Text('111111111111111111'))
                ],
              ) */
        );
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
                    child: Text('Remove Product')),
                Text(productInComparison[index].name),
                Image.network(
                  productInComparison[index].imageURL,
                  width: 155, //150,
                  height: 155,
                ),
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
                    // poduct 1
                    onPressed: () {
                      if (!productInComparison.isEmpty) {
                        print(productInComparison[0].name);
                        removeFromCompare(0);
                        setState(() {});
                      }
                    },
                    child: Text('Remove Product')),
                Text(productInComparison[0].name),
                Image.network(
                  productInComparison[0].imageURL,
                  width: 155, //150,
                  height: 155,
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Center(child: Column()) */
            SizedBox(
              height: 169,
            ),
            Center(
                child: Column(
              children: [
                Text('Add Another Product To Compare With'),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () {},
                  child: Text(
                    "View All Products",
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
        Text('No Products To Compare With'),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () {},
          child: Text(
            "View All Products",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ),
      ],
    ));
  }
}