import 'package:brandz/product_brand.dart';
import 'package:brandz/view/cart_screen.dart';
import 'package:brandz/widgets/cart_total.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meta/meta.dart';

import '../controller/cart_controller.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';

class CartProducts extends StatelessWidget {
  //final CartController controller = Get.find();

  CartProducts({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    CartController getItems = CartController();
    getItems.getId();
 Stream<QuerySnapshot> Products = FirebaseFirestore.instance
        .collection('Cart')
        .doc(CartController.id.toString())
        .collection('Products')
        .snapshots();
  
    return Scaffold(
        body: StreamBuilder(
            stream: Products,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                CartProductsCard.total = 0;
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
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_productBox(index)]),
    );
  }

  Widget _productBox(int index) {
    getTotal();
    Future.delayed(const Duration(seconds: 1), () {
      CartController().total;
    });
    return Container(
        height: 95,
        padding: const EdgeInsets.all(8.0),
        // width: 100,
        margin: EdgeInsets.all(4.0),
        child: Row(children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      data.docs[index]['productImage'])),
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
                          data.docs[index]['productBrandName'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.docs[index]['productName'] + '\nSize: X',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        Text(
                          data.docs[index]['productPrice'].toString() + ' SAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]))),
          Column(children: [
            GestureDetector(
              onTap: () async {
                var documentID;

                // this query is for getting the specific document id of the clicked product
                var collection = FirebaseFirestore.instance
                    .collection('Cart')
                    .doc(CartController.id.toString())
                    .collection('Products');
                var querySnapshots = await collection.get();
                // for assigning the id
                documentID = querySnapshots.docs[index].id;
                //deleting the product
                await FirebaseFirestore.instance
                    .collection('Cart')
                    .doc(CartController.id.toString())
                    .collection('Products')
                    .doc(documentID)
                    .delete();
                getTotal();
                await Future.delayed(const Duration(seconds: 1), () {
                  CartController().total;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 50.0, bottom: 20.0),
                child: Icon(Icons.close, color: Colors.grey[400]),
              ),
            ),
            Row(children: [
              GestureDetector(
                onTap: () async {
                  var documentID;
                  //getting the quantity for the existing user for the specific products
                  int quantity = data.docs[index]['productQuantity'];
                  // this query is for getting the specific document id of the clicked product
                  var collection = FirebaseFirestore.instance
                      .collection('Cart')
                      .doc(CartController.id.toString())
                      .collection('Products');
                  var querySnapshots = await collection.get();
                  // for assigning the id
                  documentID = querySnapshots.docs[index].id;
                  // decreasing the quantity
                  if (quantity > 1) {
                    FirebaseFirestore.instance
                        .collection('Cart')
                        .doc(CartController.id.toString())
                        .collection('Products')
                        .doc(documentID)
                        .update({'productQuantity': --quantity});
                  }
                  print("Quantity:$quantity");

                  getTotal();
                  await Future.delayed(const Duration(seconds: 1), () {
                    CartController().total;
                  });
                  // CartTotal.price = total;

                  //  controller.decreaseQuantity(product);
                },
                child: Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.remove,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(data.docs[index]['productQuantity'].toString()),
              ),
              GestureDetector(
                onTap: () async {
                  var documentID;
                  // getting the quantity for the existing user for the specific products
                  int quantity = data.docs[index]['productQuantity'];
                  // this query is for getting the specific document id of the clicked product
                  var collection = FirebaseFirestore.instance
                      .collection('Cart')
                      .doc(CartController.id.toString())
                      .collection('Products');
                  var querySnapshots = await collection.get();
                  // for assigning the id
                  documentID = querySnapshots.docs[index].id;
                  //increasing the quantity
                  FirebaseFirestore.instance
                      .collection('Cart')
                      .doc(CartController.id.toString())
                      .collection('Products')
                      .doc(documentID)
                      .update({'productQuantity': ++quantity});
                  print("Quantity:$quantity");
                  getTotal();
                  await Future.delayed(const Duration(seconds: 1), () {
                    CartController().total;
                  });
                  //CartController().total;

                  //controller.addProduct(product);
                },
                child: Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
            ])
          ])
        ]));
    CartController().total;
  }

  void getTotal() {
    double sum = 0;
    List quantityList = [];
    List priceList = [];
//print(data.size);

    FirebaseFirestore.instance
        .collection('Cart')
        .doc(CartController.id.toString())
        .collection('Products')
        .get()
        .then((doc) {
      print(doc.size);
      if (doc.size == 0) {
        sum = 0;
        total = sum;
        return;
      } else {
        //print(doc.docs[0] ['productQuantity']);
        //print(doc.docs[0] ['productPrice']);
        for (int i = 0; i < data.size; i++) {
          quantityList.add(doc.docs[i]['productQuantity']);
          priceList.add(doc.docs[i]['productPrice']);
        }
        print(quantityList[0]);
        print(priceList[0]);
        for (int i = 0; i < data.size; i++) {
          sum += quantityList[i] * priceList[i];
        }
      }

      total = sum;
    });

//print(quantityList[1]);
//sum = quantity * price;

//print(quantityList);
//print(priceList);
//print(sum);
  }
}
