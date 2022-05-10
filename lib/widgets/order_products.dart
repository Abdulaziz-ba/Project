// Flutter imports:
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/product_model.dart';
import '../view/checkout_screen.dart';
import '../view/order_complet.dart';
import 'package:async_builder/async_builder.dart';
import 'package:async_builder/init_builder.dart';

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
  bool _isLoading = true;

  @override
  void initState() {
    _getTotalFC();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    // _isLoading ? const CircularProgressIndicator() : {};
    dataSize = widget.data.docs.length - 1;

    print('index ======== ${widget.index}'); // index of product in cart
    print('data.docs.length');
    print(widget.data.docs.length);

    if (FirebaseAuth.instance.currentUser?.uid != null) {
      return AsyncBuilder<void>(
          future: _getTotalFC(),
          error: (context, error, stackTrace) => Text('Error! $error'),
          builder: (context, snapshot) {
            return Column(
                // Column(
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
          });
    } else {
      return Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text('ERROR?')]),
      );
    }
  }

  Future sendEmailOLD({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_bub97q7';
    const templateId = 'template_rzcgui9';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'orgin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': '7XALWNk_4BTR0SW8W',
        'template_params': {
          'to_name': name,
          //'from_name': 'BRANDZ',
          'email_to': email,
          'from_email': 'brandz.gp@gmail.com',
          'subject': subject,
          'message': message,
        }
      }),
    );

    print(response.body);
    return response.statusCode;
  }

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String image,
    required String brand,
    required String item_name,
    required String size,
    required String price,
    required String item_qty,
    required String order_number,
    required String order_date,
    required String shipping_address,
  }) async {
    const serviceId = 'service_bub97q7';
    const templateId = 'template_fjm0emd';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'orgin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': '7XALWNk_4BTR0SW8W',
        'template_params': {
          'to_name': name,
          'email_to': email,
          'from_email': 'brandz.gp@gmail.com',
          'subject': subject,
          'item_image': image,
          'item_brand': brand,
          'item_name': item_name,
          'item_size': size,
          'item_price': price,
          'item_qty': item_qty,
          'total': total,
          'order_number': order_number,
          'order_date': order_date,
          'shipping_address': shipping_address,
        }
      }),
    );

    print(response.body);
    return response.statusCode;
  }

  _nav() async {
    await Future.delayed(Duration(seconds: 1));
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
    Future.delayed(const Duration(seconds: 1), () {
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
    List<Product> products = [];
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
      products.add(Product(
          name: data['productName'],
          price: data['productPrice'],
          imageURL: data['productImage'],
          brandName: data['productBrandName'],
          quantitiy: data['productQuantity'],
          description: data['productDescription'],
          size: data['productSize']));
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
    dynamic order_number = getOrderNumber();

    Map<String, dynamic> data = <String, dynamic>{
      "orderNumber": order_number, //Random().nextInt(100 - 1),
      "customerID": userID!,
      "products": FieldValue.arrayUnion(yourProductsList),
      "totalPrice": _getTotal(productsPrices, productsQuantitiys),
      "orderDate": DateTime.now(),
    };
    //print("order number =======================");
    //print(getOrderNumber());
    // add order to database
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection("Orders").doc();
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Order added to the database"))
        .catchError((e) => print(e));

    // get user data
    String userName = '';
    String userEmail = '';
    String message2 = '';
    /*  String message =
        '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<img class="adapt-img" src="assets/logo_size.jpg" alt width="105"> </html>'''; */

    //String phone = '';
    String userLocation = '';
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      final fname = userData.data()!['FirstName'];
      final lname = userData.data()!['LastName'];
      final email = userData.data()!['email'];
      //final phone = userData.data()!['phone'];
      final location = userData.data()!['location'];
      userName = fname + ' ' + lname;
      userEmail = email;
      userLocation = location;
    });
    Future.delayed(const Duration(seconds: 1), () {
      // send an email
      /* sendEmailOLD(
        name: userName,
        email: userEmail,
        subject: 'Your order has been placed',
        message:
            message2, //'Thank you for shopping with BRANDZ', // here we should add the html templete for the order
      ); */
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String dateFormatted = formatter.format(now);
      sendEmail(
        name: userName,
        email: userEmail,
        subject: 'Your order has been placed',
        image: products[0].imageURL,
        brand: products[0].brandName,
        item_name: products[0].name,
        size: products[0].size,
        price: products[0].price.toString(),
        item_qty: products[0].quantitiy.toString(),
        order_number: order_number.toString(),
        order_date: dateFormatted,
        shipping_address: userLocation,
      );
    });
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
    /* Future.delayed(const Duration(seconds: 2), () {
      _getTotalFC();
    }); */
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

  Future<void> _getTotalFC() async {
    double sum = 0;
    List quantityList = [];
    List priceList = [];
//print(data.size);

    await FirebaseFirestore.instance
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

  getOrderNumber() {
    return DateTime.now().millisecondsSinceEpoch + Random().nextInt(100000);
  }
}
