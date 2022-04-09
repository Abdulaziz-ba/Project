import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';


class product_page extends StatelessWidget {
String id;

product_page({required this.id});

  @override
  Widget build(BuildContext context) {
final productData = FirebaseFirestore.instance
      .collection('Products')
      .doc(id)
      .snapshots();
   return Container(
        child: StreamBuilder(
            stream: productData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("first if");
              }
              if (snapshot.hasError) {
                return Text("There is an error");
              }
            DocumentSnapshot<Object?>  data = snapshot.requireData;

              return Scaffold(
                     appBar: AppBar(
                    backgroundColor: Colors.white,
                    leading: BackButton(color: Colors.black),
                    centerTitle: true,
                    title: const Text('Product details',
                        style: TextStyle(color: Colors.black)),
                  ),


                body: Image.network(
                  data['image']
                )






              );

  }));
}}