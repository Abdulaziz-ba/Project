import 'dart:async';

import 'package:brandz/model/product_model.dart';
import 'package:brandz/widgets/cart_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
 import '../model/product_model.dart';
import 'package:collection/collection.dart';
import "package:brandz/model/user_model.dart";
class CartController{
  var _products = {}.obs;
  static var id;
  static var Total = 0.obs;
  final _auth = FirebaseAuth.instance;

  void addProduct(Product product ,  User? user) {
   FirebaseFirestore.instance.collection("Cart").get().then((querySnapshot) {
   querySnapshot.docs.forEach((doc){
    if(doc.data()['cartId'] == user!.uid){
                       id = doc.id; // randomly generated document ID
                      }
    });
    querySnapshot.docs.forEach((doc){
      if (doc.data()['cartId'].toString() == user!.uid.toString()) {
        print(id);
         FirebaseFirestore.instance.collection('Cart').doc(id)
         .collection('Products').add({
           
           'productName' : product.name ,
           'productImage' : product.imageURL ,
           'productPrice' : product.price ,
           'productBrandName' : product.brandName,
           'productQuantity' : product.quantitiy
         }
          
         );

      }
       else { 
     
    } 
    });
  });
  }


  //get products => _products;

  //get ProductSubtotal => _products.entries.map((product) => product.key.price * product.value).toList();

  get total  {
  Total.value = 0;
  Total.value = CartProductsCard.total.toInt();
  return Total;

  }
void getId(){
User? user = _auth.currentUser;
UserModel userModel = UserModel();
FirebaseFirestore.instance.collection("Cart").get().then((querySnapshot) {
querySnapshot.docs.forEach((doc){
if(doc.data()['cartId'] == user!.uid){
        id = doc.id; // randomly generated document ID
          }
    });

  }
      );}

}