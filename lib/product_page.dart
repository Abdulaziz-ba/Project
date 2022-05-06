// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import "controller/cart_controller.dart";
import 'model/product_model.dart';
import 'model/user_model.dart';
import 'view/cart_screen.dart';
import 'view/compare_screen.dart';

//import 'package:photo_view/photo_view_gallery.dart';
//import 'package:photo_view/photo_view.dart';

class product_page extends StatefulWidget {
  String id;

  product_page({required this.id});

  @override
  State<product_page> createState() => _product_pageState();
}

class _product_pageState extends State<product_page> {
  final _auth = FirebaseAuth.instance;

  int pressed = 0;
  late String? newValue = '';
  final cartController = Get.put(CartController());

  List<String> items = [];

  String? value;

  List urlimages = [];

  List Sizes = [];

  bool entered = false;
  @override
  Widget build(BuildContext context) {
    final productData = FirebaseFirestore.instance
        .collection('Products')
        .doc(widget.id)
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
          DocumentSnapshot<Object?> data = snapshot.requireData;

          urlimages = data["image"];
          Sizes = data['Size'];
          SizesFromDataBase(Sizes.length);

          /* void openGalley() => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GalleryWidget(
                  urlImages: urlimages,
                ),
              ));*/

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Product Details ',
                style: GoogleFonts.adamina(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white10,
              leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              elevation: 0.0,
              actions: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white10),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => CartPage(
                                        BrandName: '',
                                      )));
                        },
                        child: Icon(
                          Icons.wallet_giftcard,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 26,
                    )
                  ],
                )
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60),
                            topRight: Radius.circular(60),
                            topLeft: Radius.circular(60),
                          ),
                          //
                        ),
                        child: PageView(
                          children: [
                            for (var i = 0; i < urlimages.length; i++)
                              Container(
                                child: Image.network(urlimages[i]),
                              ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Product Name Field
                            Text(
                              data["name"],
                              // "Perfume",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Product Price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data["Size"][productIndex()]['price'] +
                                      " SAR",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  height: 40,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          var thisProduct = Product(
                                              imageURL: data["image"][0],
                                              name: data['name'],
                                              price: double.parse(data['Size']
                                                  [productIndex()]['price']),
                                              brandName: data['BrandName'],
                                              quantitiy: 1,
                                              description: data['description'],
                                              size: data['Size'][productIndex()]
                                                  ['size']);
                                          if (ComparePage
                                                  .productInComparison.length ==
                                              0) {
                                            // ADD TO COMP
                                            print('added to comp1');
                                            ComparePage.productInComparison
                                                .add(thisProduct);
                                            //++ComparePage.itemsInComp;
                                          } else if (ComparePage
                                                  .productInComparison.length ==
                                              1) {
                                            // ADD TO COMP
                                            // change to product id later!
                                            bool contains = ComparePage
                                                .productInComparison
                                                .any((e) =>
                                                    e.name == thisProduct.name);
                                            //bool contains = ComparePage.productInComparison.contains(thisProduct);
                                            print("contains = $contains");
                                            if (!contains) {
                                              print('added to comp2');

                                              ComparePage.productInComparison
                                                  .add(thisProduct);

                                              // nav to compare
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComparePage()),
                                              );
                                              //++ComparePage.productInComparison;
                                            } else {
                                              print(
                                                  'product already in compare!');
                                            }
                                          } else {
                                            print(
                                                'sorry we cant compare more than 2 products!');
                                          }
                                        },
                                        icon: Icon(
                                          Icons.compare_arrows,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(300),
                                  ),
                                  child: DropdownButton<String>(
                                      elevation: 0,
                                      hint: Text(
                                        Sizes[0]['size'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      value: value,
                                      items: items.map(buildMenuItem).toList(),
                                      onChanged: (valueNew) {
                                        setState(() {
                                          value = valueNew;
                                          newValue = valueNew;
                                        });
                                      }),
                                ),
                              ],
                            ),
                            Text(
                              "About Product",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              data["description"],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 170,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    onPressed: () async {
                                      if (newValue == '') {
                                        newValue = Sizes[0]['size'];
                                        print('I am here too');
                                      }

                                      bool found = false;
                                      User? user = _auth.currentUser;
                                      UserModel userModel = UserModel();
                                      String Brand = data['name'].toString();
                                      var noteInfo = data!.data()! as Map;
                                      var object = Product(
                                        //1
                                        imageURL: noteInfo['image'][0],
                                        name: noteInfo['name'],
                                        price: double.parse(noteInfo['Size']
                                            [productIndex()]['price']),
                                        brandName: noteInfo['BrandName'],
                                        quantitiy: 1,
                                        description: noteInfo['description'],
                                        size: newValue,
                                      );
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .collection('Cart')
                                          .get()
                                          .then((querySnapshot) async {
                                        print(querySnapshot.docs);
                                        print(CartController.id);
                                        querySnapshot.docs.forEach((doc) {
                                          if (doc.data()['productImage'] ==
                                                  noteInfo['image'][0] &&
                                              newValue ==
                                                  doc.data()['productSize']) {
                                            found = true;
                                          }
                                        });
                                        if (found == true) {
                                          return;
                                        } else {
                                          if (pressed == 0) {
                                            print('I am here');
                                            AddToCart(object, user);
                                            ++pressed;
                                          }
                                          return;
                                        }
                                      });
                                    },
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    onPressed: () async {
                                      dynamic displayProduct =
                                          data.id.toString();
                                      print(displayProduct);
                                      User? user = _auth.currentUser;
                                      UserModel userModel = UserModel();
                                      var noteInfo = data.data()! as Map;
                                      var object = Product(
                                          imageURL: noteInfo['image'][0],
                                          name: noteInfo['name'],
                                          price: double.parse(
                                              noteInfo['Size'][0]['price']),
                                          brandName: noteInfo['BrandName'],
                                          quantitiy: 1,
                                          description: noteInfo['description']
                                              .toString(),
                                          size: null);
                                      if (FirebaseAuth
                                              .instance.currentUser?.uid ==
                                          null) {
                                        return;
                                      } else if (FirebaseAuth
                                              .instance.currentUser?.uid !=
                                          null) {
                                        var value = await FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .collection('Favourites')
                                            .limit(1)
                                            .get();
                                        if (value.docs.isNotEmpty == false) {
                                          print('hiihihhiih');
                                          AddToFavourites(object, user);

                                          return;
                                        }

                                        bool found = false;
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .collection('Favourites')
                                            .get()
                                            .then((querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            //  print( noteInfo['BrandName']);
                                            if (doc.data()['productBrandName'] ==
                                                        noteInfo['BrandName'] &&
                                                    doc.data()[
                                                            'productDescription'] ==
                                                        noteInfo[
                                                            'description'] &&
                                                    doc.data()['productName'] ==
                                                        noteInfo['name'] //&&
                                                //  doc.data()['productPrice'] == noteInfo['price']
                                                ) {
                                              found = true;
                                            }
                                          });
                                          if (found == true) {
                                            return;
                                          } else {
                                            AddToFavourites(object, user);

                                            return;
                                          }
                                        });
                                      }
                                    },
                                    color: Colors.red,
                                    child: Text(
                                      "Add to Favorite",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
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
    } catch (e) {
      e.toString();
    }
  }

  void AddToFavourites(Product product, User? user) async {
    var id;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Favourites')
        .add({
      'productName': product.name,
      'productImage': product.imageURL,
      'productPrice': product.price,
      'productBrandName': product.brandName,
      'productQuantity': product.quantitiy,
      'productDescription': product.description
    });
  }

  void SizesFromDataBase(int length) {
    if (entered == false) {
      for (int i = 0; i < length; i++) {
        items.add(Sizes[i]['size']);
      }
      entered = true;
    }
  }

  int productIndex() {
    for (int i = 0; i < Sizes.length; i++) {
      if (Sizes[i]['size'] == newValue) {
        return i;
      }
    }

    return 0;
  }
}
