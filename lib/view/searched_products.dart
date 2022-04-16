import 'package:brandz/model/user_model.dart';
import 'package:brandz/product_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:brandz/controller/cart_controller.dart";
import 'package:google_fonts/google_fonts.dart';
import '../model/product_model.dart';

import 'package:brandz/view/auth/login_screen.dart';

var data;
bool flag = true;

class Serached_products extends StatelessWidget {
  String id;
  String brand;
  late String displayBrand;

  Serached_products({required this.id, required this.brand});
  @override
  Widget build(BuildContext context) {
    print(brand);
    final Stream<QuerySnapshot> products = FirebaseFirestore.instance
        .collection('Products')
        .where('name', isGreaterThanOrEqualTo: id.capitalizeFirst)
        .snapshots();
    final Stream<QuerySnapshot> brandProduct = FirebaseFirestore.instance
        .collection('Products')
        .where('BrandName', isEqualTo: id.capitalizeFirst)
        .snapshots();
    var finalProducts;
    if (brand == "brand") {
      finalProducts = brandProduct;
    } else {
      finalProducts = products;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black),
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream: finalProducts,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("");
                }
                if (snapshot.hasError) {
                  return Text("");
                }
                data = snapshot.requireData;

                return Expanded(
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: GridView.builder(
                            itemCount: data.size,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return ProductCardSearch(index: index);
                            })));
              }),
        ));
  }
}

class ProductCardSearch extends StatelessWidget {
  final cartController = Get.put(CartController());
  final _auth = FirebaseAuth.instance;
  int pressed = 0;
  final int index;
  ProductCardSearch({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('product index $index');
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_productBox(index, context)]),
    );
  }

  Widget _productBox(int index, BuildContext context) {
    return Container(
        child: FlatButton(
      onPressed: () async {
        dynamic displayProduct = data.docs[index].id.toString();
        User? user = _auth.currentUser;
        UserModel userModel = UserModel();
        var noteInfo = data!.docs[index].data()! as Map;
        var object = Product(
            imageURL: noteInfo['image'],
            name: noteInfo['name'],
            price: double.parse(noteInfo['price']),
            brandName: noteInfo['BrandName'],
            quantitiy: 1,
            description: noteInfo['description'].toString(),
            size: noteInfo['Size'][0]['size']);
        if (FirebaseAuth.instance.currentUser?.uid == null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => product_page(id: displayProduct)));
        } else if (FirebaseAuth.instance.currentUser?.uid != null) {
          var value = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('LastViewdProducts')
              .limit(1)
              .get();
          if (value.docs.isNotEmpty == false) {
            lastVisitedProducts(object, user);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => product_page(id: displayProduct)));
            return;
          }

          bool found = false;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('LastViewdProducts')
              .get()
              .then((querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              print(doc.data()['productBrandName'] == noteInfo['BrandName']);
              print(
                  doc.data()['productDescription'] == noteInfo['description']);
              print(doc.data()['productName'] == noteInfo['name']);
              print(doc.data()['productPrice'] == noteInfo['price']);
              //  print( noteInfo['BrandName']);
              if (doc.data()['productBrandName'] == noteInfo['BrandName'] &&
                      doc.data()['productDescription'] ==
                          noteInfo['description'] &&
                      doc.data()['productName'] == noteInfo['name'] //&&
                  //  doc.data()['productPrice'] == noteInfo['price']
                  ) {
                found = true;
              }
            });
            if (found == true) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => product_page(id: displayProduct)));
              return;
            } else {
              lastVisitedProducts(object, user);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => product_page(id: displayProduct)));
              return;
            }
          });
        }
      },
      child: Column(
        children: [
          Text(data.docs[index]['name'] + "- " + data.docs[index]['BrandName'],
              style: GoogleFonts.adamina(
                fontSize: 16,
              )),
          // Text(data.docs[index]['BrandName'],
          //     style: GoogleFonts.adamina(
          //       fontSize: 13,
          //     )),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    print('hello');
                    bool found = false;
                    User? user = _auth.currentUser;
                    UserModel userModel = UserModel();
                    String Brand = data.docs[index]['name'].toString();
                    var noteInfo = data!.docs[index].data()! as Map;
                    var object = Product(
                        imageURL: noteInfo['image'],
                        name: noteInfo['name'],
                        price: double.parse(noteInfo['price']),
                        brandName: noteInfo['BrandName'],
                        quantitiy: 1,
                        description: noteInfo['description'],
                        size: noteInfo['Size'][0]['size']);
                    await FirebaseFirestore.instance
                        .collection("Cart")
                        .doc(CartController.id)
                        .collection('Products')
                        .get()
                        .then((querySnapshot) async {
                      querySnapshot.docs.forEach((doc) {
                        print(doc.data()['productImage'] == noteInfo['image']);
                        if (doc.data()['productImage'] == noteInfo['image']) {
                          found = true;
                        }
                      });
                      if (found == true) {
                        return;
                      } else {
                        if (pressed == 0)
                          cartController.addProduct(object, user);
                        ++pressed;
                        return;
                      }
                      ;
                    });
                  },
                  icon: Icon(Icons.shopping_cart_checkout_rounded))
            ],
          ),
          Image.network(
            data.docs[index]['image'],
            width: 100,
            height: 87,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(data.docs[index]['price'] + ' SAR',
                style: GoogleFonts.adamina(
                  fontSize: 14,
                )),
          ),
        ],
      ),
    ));
  }

  void lastVisitedProducts(Product product, User? user) async {
    var id;

    print(id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('LastViewdProducts')
        .add({
      'productName': product.name,
      'productImage': product.imageURL,
      'productPrice': product.price,
      'productBrandName': product.brandName,
      'productQuantity': product.quantitiy,
      'productDescription': product.description
    });
  }
}
