// Flutter imports:
import 'dart:math';

import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/checkout_screen.dart';
import '../view/order_complet.dart';

class OrderProducts extends StatelessWidget {
  OrderProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('Cart')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                print('NO DATA!');
                return Text("NO DATA!");
              }
              if (snapshot.hasError) {
                print('ERROR!');
                return Text("ERROR!");
              }
              final data = snapshot.requireData;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return OrderProductsCard(data: data, index: index);
                  });
            }));
  }
}

class OrderProductsCard extends StatefulWidget {
  final int index;
  final QuerySnapshot<Object?> data;

  OrderProductsCard({required this.data, required this.index});

  @override
  State<OrderProductsCard> createState() => _OrderProductsCardState();
}

class _OrderProductsCardState extends State<OrderProductsCard> {
  int dataSize = 0;

  bool isButtonActive = false;
  int _val = -1;
  static double total = 0;

  Widget build(BuildContext context) {
    dataSize = widget.data.docs.length - 1;

    print('index ======== ${widget.index}'); // index of product in cart
    print('data.docs.length');
    print(widget.data.docs.length);

    if (FirebaseAuth.instance.currentUser?.uid != null) {
      return Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.index == 0) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: 50,
                  width: double.infinity,
                  //color: Color.fromARGB(30, 0, 0, 0),
                  child: Center(
                    child: Text(
                      'Review Your Order',
                      style: GoogleFonts.adamina(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              //),
            ],
            Card(child: _productBox(widget.index)),
            if (widget.index == dataSize) ...[
              totalBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Payment Method',
                      style: GoogleFonts.adamina(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _val,
                        onChanged: (int? value) {
                          setState(() {
                            _val = value!;

                            isButtonActive = true;
                          });
                        },
                        //activeColor: Colors.green,
                      ),
                      Text(
                        'Cash on delivery',
                        style: GoogleFonts.adamina(
                            fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                    child: FlatButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width -
                            20, //double.infinity - 20,
                        color: Color.fromARGB(70, 0, 129, 172),
                        shape: RoundedRectangleBorder(
                            //side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        textColor: Colors.black,
                        disabledColor: Colors.black12,
                        disabledTextColor: Colors.blueGrey,
                        onPressed: isButtonActive
                            ? () async {
                                // add cart items to order  && empty the cart

                                await Create_New_Order();

                                await Empty_The_Cart();

                                // navigate to next page
                                await _nav();
                              }
                            : null,
                        child: Text(
                          'Pay Now',
                          style: GoogleFonts.adamina(
                            //fontWeight: FontWeight.bold,
                            fontSize: 16,
                            //color: Colors.black
                          ),
                        )),
                  )),
            ],
          ]);
    } else {
      return Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text('ERROR?')]),
      );
    }
  }

  _nav() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted)
      Navigator.pushAndRemoveUntil(
        context, //context,
        MaterialPageRoute(
          builder: (BuildContext context) => Order_Completed(),
        ),
        (route) => false,
      );
  }

  Future<void> Empty_The_Cart() async {
    Future.delayed(const Duration(seconds: 3), () {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Cart')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    });

    print('cart is empty!!');
  }

  Future<void> Create_New_Order() async {
    //List<Product> products = [];
    List productsNames = [];
    List productsPrices = [];
    List productsImages = [];
    List productsBrandNames = [];
    List productsQuantitiys = [];
    List productsSizs = [];

    List yourProductsList = [];

    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Cart');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      productsNames.add(data['productName']);
      productsBrandNames.add(data['productBrandName']);
      productsImages.add(data['productImage']);
      productsPrices.add(data['productPrice']);
      productsQuantitiys.add(data['productQuantity']);
      productsSizs.add(data['productSize']);
      print('SIZE ======================= ' + data['productSize']);
    }

    for (int i = 0; i < productsNames.length; i++)
      yourProductsList.add({
        "name": productsNames[i],
        "price": productsPrices[i],
        "imageURL": productsImages[i],
        "brandName": productsBrandNames[i],
        "quantitiy": productsQuantitiys[i],
        "size": productsSizs[i],
      });

    String? userID = FirebaseAuth.instance.currentUser?.uid;

    Map<String, dynamic> data = <String, dynamic>{
      "orderNumber": Random().nextInt(100 - 1),
      "customerID": userID!,
      "products": FieldValue.arrayUnion(yourProductsList),
      "totalPrice": _getTotal(productsPrices, productsQuantitiys),
      "orderDate": DateTime.now(),
    };

    // add order to database
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection("Orders").doc();
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Order added to the database"))
        .catchError((e) => print(e));
  }

  double _getTotal(List price, List quantitiy) {
    double sum = 0;

    if (price.isEmpty) {
      print('product is empty');
      return 0;
    } else {
      for (int i = 0; i < price.length; i++) {
        sum += price[i] * quantitiy[i];
      }
    }
    print('total is = $sum');
    return sum;
  }

  Widget _productBox(int index) {
    return Container(
        height: 120,
        padding: const EdgeInsets.all(8.0),
        // width: 100,
        margin: EdgeInsets.all(4.0),
        child: Row(children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      widget.data.docs[index]['productImage'])),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.docs[index]['productBrandName'],
                          style: GoogleFonts.adamina(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.data.docs[index]['productName'],
                          style: GoogleFonts.adamina(
                              fontSize: 15, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.data.docs[index]['productSize'],
                          style: GoogleFonts.adamina(
                              fontSize: 15, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.data.docs[index]['productPrice']
                                      .toString() +
                                  ' SAR',
                              style: GoogleFonts.adamina(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            Text(
                              'Qty ' +
                                  widget.data.docs[index]['productQuantity']
                                      .toString(),
                              style: GoogleFonts.adamina(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ]))),
        ]));
  }

  Widget totalBox() {
    _getTotalFC();
    Future.delayed(const Duration(seconds: 5), () {});
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //color: Color.fromARGB(30, 0, 0, 0),

        //color: Color.fromARGB(70, 0, 129, 172),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub-total:',
                  style: GoogleFonts.adamina(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Text(
                  '${total} SAR',
                  style: GoogleFonts.adamina(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery:',
                  style: GoogleFonts.adamina(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Text(
                  'Free',
                  style: GoogleFonts.adamina(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total to pay:',
                  style: GoogleFonts.adamina(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Text(
                  '${total} SAR',
                  style: GoogleFonts.adamina(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _getTotalFC() {
    double sum = 0;
    List quantityList = [];
    List priceList = [];
//print(data.size);

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Cart')
        .get()
        .then((doc) {
      print(doc.size);
      if (doc.size == 0) {
        sum = 0;
        total = sum;
        print("1st if ==========================");
      } else {
        //print(doc.docs[0] ['productQuantity']);
        //print(doc.docs[0] ['productPrice']);
        for (int i = 0; i < widget.data.size; i++) {
          quantityList.add(doc.docs[i]['productQuantity']);
          priceList.add(doc.docs[i]['productPrice']);
        }
        print(quantityList[0]);
        print(priceList[0]);
        for (int i = 0; i < widget.data.size; i++) {
          sum += quantityList[i] * priceList[i];
        }
      }
      print("2222 if ==========================");
      total = sum;
    });
    print("3333333 if ==========================");

//print(quantityList[1]);
//sum = quantity * price;

//print(quantityList);
//print(priceList);
//print(sum);
  }
}
