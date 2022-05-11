//import 'package:brandz/model/category_model.dart';
//import 'package:brandz/model/home_view_model.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../Favourites.dart';
import '../brand_Category.dart';
import '../model/control_view_model.dart';
import '../product_brand.dart';
import '../product_page.dart';
import '../view/auth/login_screen.dart';
import '../widgets/searched_products.dart';

final controller = ControlViewModel();
late String id;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "home1".tr,
          style: GoogleFonts.adamina(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Favourites()));
                    },
                    child: Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.black,
                    )),
              ),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white10),
                child: FlatButton(
                  onPressed: () {
                    final _auth = FirebaseAuth.instance;
                    _auth.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Icon(
                    Icons.logout,
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

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              _searchBox(),
              Image(image: AssetImage("assets/woman-black-dress-hm.jpg")),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "home2".tr,
                        style: GoogleFonts.adamina(
                            color: Colors.black, fontSize: 22),
                      ),
                    ),
                    _listViewCategory(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "home3".tr,
                          style: GoogleFonts.adamina(
                              color: Colors.black, fontSize: 22),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => BrandzCategory(
                                            id: "ALL",
                                          )));
                            },
                            child: Text(
                              "home4".tr,
                              style: GoogleFonts.adamina(
                                  color: Colors.black,
                                  fontSize: 18,
                                  backgroundColor: Colors.grey[100]),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //container
                    _listViewBrands(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "home5".tr,
                          style: GoogleFonts.adamina(
                              color: Colors.black, fontSize: 22),
                        ),
                        FlatButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('LastViewdProducts')
                                  .get()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.docs) {
                                  ds.reference.delete();
                                }
                              });
                            },
                            child: Text(
                              "home6".tr,
                              style: GoogleFonts.adamina(
                                  color: Colors.black,
                                  fontSize: 18,
                                  backgroundColor: Colors.grey[100]),
                            )),
                      ],
                    ),
                    _listViewProduct(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      // bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}

@override
//final Homemodel = HomeViewModel();
// retrieving the category name when button is pressed
late String displayCategory;
// retrieving the brand name when button is pressed
late String displayBrand;

Widget _searchTextFormField() {
  return Container(
    height: 30,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
    child: TextFormField(
      decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          )),
    ),
  );
}

Widget _listViewCategory() {
  final Stream<QuerySnapshot> categories =
      FirebaseFirestore.instance.collection('Categories').snapshots();
  return Container(
    height: 100,
    child: StreamBuilder(
        stream: categories,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("");
          }
          if (snapshot.hasError) {
            return Text("");
          }
          final data = snapshot.requireData;

          return ListView.separated(
            itemCount: data.size,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  FlatButton(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        height: 70,
                        width: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            data.docs[index]['image'],
                          ),
                        ),
                      ),
                      onPressed: () {
                        displayCategory = data.docs[index]['name'].toString();
                        FirebaseFirestore.instance
                            .collection("Categories")
                            .get()
                            .then((querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            if (doc.data()['name'] == displayCategory) {
                              var id = doc.id; // randomly generated document ID
                              var data = doc.data();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BrandzCategory(
                                          id: id,
                                        )),
                              );
                            }
                          });
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.docs[index]['name'],
                    style: GoogleFonts.adamina(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
            separatorBuilder: (context, int index) => SizedBox(
              width: 20,
            ),
          );
        }),
  );
}

Widget _listViewBrands() {
  final Stream<QuerySnapshot> brands =
      FirebaseFirestore.instance.collection('Brands').snapshots();
  return Container(
    height: 100,
    child: StreamBuilder(
        stream: brands,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("");
          }
          if (snapshot.hasError) {
            return Text("");
          }
          final data = snapshot.requireData;

          return ListView.separated(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    children: [
                      FlatButton(
                        onPressed: () {
                          displayBrand = data.docs[index]['name'].toString();
                          FirebaseFirestore.instance
                              .collection("Brands")
                              .get()
                              .then((querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              if (doc.data()['name'] == displayBrand) {
                                id = doc.id; // randomly generated document ID
                                var data = doc.data();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => product_brand(
                                            id: id,
                                          )),
                                );
                              }
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.white,
                          ),
                          height: 70,
                          width: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              data.docs[index]['image'],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.docs[index]['name'],
                        style: GoogleFonts.adamina(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (context, int index) => SizedBox(
              width: 20,
            ),
          );
        }),
  );
}

Widget _listViewProduct() {
  final Stream<QuerySnapshot> products = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('LastViewdProducts')
      .snapshots();

  final _auth = FirebaseAuth.instance;
  return Container(
      height: 220,
      child: StreamBuilder(
          stream: products,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("");
            }
            if (snapshot.hasError) {
              return Text("");
            }
            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.size,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return FlatButton(
                  onPressed: () async {
                    dynamic displayProduct = data.docs[index].id.toString();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            product_page(id: displayProduct.toString())));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    shadowColor: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Container(
                                height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.network(
                                    data.docs[index]['productImage'],
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ),
                          SizedBox(height: 7),
                          Text(
                            data.docs[index]['productBrandName'],
                            style: GoogleFonts.adamina(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            data.docs[index]['productPrice'].toString() +
                                "home7".tr,
                            style: GoogleFonts.adamina(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }));
}

Widget _bottomNavigationBar() {
  return BottomNavigationBar(
    items: [
      BottomNavigationBarItem(
          activeIcon: Text('Explore'),
          label: '',
          icon: Image.asset(
            'assets/images/Icon_Explore.png',
            fit: BoxFit.contain,
          )),
      BottomNavigationBarItem(
          activeIcon: Text('Cart'),
          label: '',
          icon: Image.asset(
            'assets/images/Icon_Cart.png',
            fit: BoxFit.contain,
          )),
      BottomNavigationBarItem(
          activeIcon: Text('User'),
          label: '',
          icon: Image.asset(
            'assets/images/Icon_User.png',
            fit: BoxFit.contain,
          )),
    ],
    currentIndex: controller.navigatorValue,
    onTap: (index) {
      controller.changeSelectedValue(index);
      if (index == 1) {
        //Get.to(CartView());
      }
    },
    selectedItemColor: Colors.black,
    backgroundColor: Colors.grey.shade100,
  );
}

bool datacheck = false;
final Stream<QuerySnapshot> brandNames =
    FirebaseFirestore.instance.collection("Products").snapshots();
var brandsNamesData;
final _formKey = GlobalKey<FormState>();
Widget _searchBox() {
  return Container(
    child: StreamBuilder(
      stream: brandNames,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }
        if (snapshot.hasError) {
          return Text("");
        }
        final brandsNamesData = snapshot.requireData;

        return Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                  prefixIcon: Icon(Icons.search),
                  hintText: "home8".tr,
                  border: OutlineInputBorder(),
                  filled: false,
                ),
                onFieldSubmitted: (text) async {
                  if (text == '') return;
                  bool flag = datacheck;
                  await FirebaseFirestore.instance
                      .collection("Products")
                      .get()
                      .then((value) {
                    value.docs.forEach((doc) {
                      print(doc.data()['BrandName']);

                      if (doc.data()['BrandName'].toString() ==
                          text.capitalizeFirst) {
                        flag = true;
                      }
                    });
                  });

                  if (flag) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Serached_products(
                                  id: text,
                                  brand: "brand",
                                )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Serached_products(
                                  id: text,
                                  brand: "product",
                                )));
                  }
                },
              ),
            ),
          ]),
        );
      },
    ),
  );
}
