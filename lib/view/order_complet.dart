import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_screen.dart';

class Order_Completed extends StatelessWidget {
  Order_Completed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderNumber;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        //backgroundColor: Colors.pink,

        //leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Checkout',
          style: GoogleFonts.adamina(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Orders')
              .where('customerID',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .orderBy("orderDate", descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final data = snapshot.requireData;
            final orderDoc = data.docs[0];
            if (orderDoc.exists) {
              orderNumber = orderDoc['orderNumber'];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/Success.gif'),
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Successful',
                      style: GoogleFonts.adamina(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Thank You For Your Purchase!',
                      style: GoogleFonts.adamina(
                          fontSize: 15, color: Colors.black),
                    ),
                  ),

                  // get lastest order for this user then get order number

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your Order Number is: $orderNumber",
                      style: GoogleFonts.adamina(
                          fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: FlatButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width -
                            50, //double.infinity - 20,
                        color: Color.fromARGB(70, 0, 129, 172),
                        shape: RoundedRectangleBorder(
                            //side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const MainPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Return To Homepage',
                          style: GoogleFonts.adamina(
                              fontSize: 15, color: Colors.black),
                        )),
                  )
                ],
              ),
            );
          }),
    );
  }
}
