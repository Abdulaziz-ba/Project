// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          'My Orders',
          style: GoogleFonts.adamina(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: OrderProducts()),
          ]),
    );
  }
}

class OrderProducts extends StatelessWidget {
  OrderProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            /* FirebaseFirestore.instance.collection('Orders').where('customerID',isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(), */
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .where('customerID',
                    isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .orderBy("orderDate", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              final data = snapshot.requireData;

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        OrderProductsCard(data: data, index: index),
                        SizedBox(height: 25)
                      ],
                    );
                  });
            }));
  }
}

class OrderProductsCard extends StatelessWidget {
  final int index;
  final QuerySnapshot<Object?> data;
  static double total = 0;

  int productsLength = 0;
  OrderProductsCard({required this.data, required this.index});

  Widget build(BuildContext context) {
    productsLength = data.docs[index]['products'].length;

    if (FirebaseAuth.instance.currentUser?.uid != null) {
      return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              orderHeader(index),
              for (var i = 0; i < productsLength; i++) _productBox(index, i),
            ]),
      );
    } else {
      return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[]),
      );
    }
  }

  Widget _productBox(int order_index, int product_index) {
    List products = List.from(data.docs[order_index]['products']);

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
                      products[product_index]['imageURL'])),
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
                          products[product_index]['brandName'],
                          style: GoogleFonts.adamina(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          products[product_index]['name'],
                          style: GoogleFonts.adamina(
                              fontSize: 15, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          products[product_index]['size'],
                          style: GoogleFonts.adamina(
                              fontSize: 15, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              products[product_index]['price'].toString() +
                                  ' SAR',
                              style: GoogleFonts.adamina(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            Text(
                              'Qty ' +
                                  products[product_index]['quantitiy']
                                      .toString(),
                              style: GoogleFonts.adamina(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ]))),
        ]));
  }

  Widget orderHeader(int order_index) {
    //date of order
    //order number
    //total
    String orderDate = _getDateOfOrder(order_index);
    int orderNumber = _getOrderNumber(order_index);
    double total = _getTotal(order_index);
    Future.delayed(const Duration(seconds: 3), () {});
    return Container(
      height: 75,
      color: Color.fromARGB(30, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Date: $orderDate',
                  style: GoogleFonts.adamina(fontSize: 15, color: Colors.black),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order#: $orderNumber',
                  style: GoogleFonts.adamina(fontSize: 15, color: Colors.black),
                ),
                Text(
                  'Total: $total SAR',
                  style: GoogleFonts.adamina(fontSize: 15, color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String _getDateOfOrder(int order_index) {
    Timestamp orderDate = data.docs[order_index]['orderDate'];

    var dt =
        DateTime.fromMillisecondsSinceEpoch(orderDate.millisecondsSinceEpoch);

// 12 Hour format:
    //var d12 =DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

// 24 Hour format:
    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    return d24;
  }

  int _getOrderNumber(int order_index) {
    int orderNumber = data.docs[order_index]['orderNumber'];
    return orderNumber;
  }

  double _getTotal(int order_index) {
    double sum = 0;
    List products = List.from(data.docs[order_index]['products']);
    for (var i = 0; i < products.length; i++) {
      sum += products[i]['quantitiy'] * products[i]['price'];
    }

    return sum;
  }
}
