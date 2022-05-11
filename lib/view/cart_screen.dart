// Flutter imports:
import 'package:brandz/view/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../product_page.dart';
import '../widgets/cart_products.dart';
import '../widgets/cart_total.dart';
import 'checkout_screen.dart';

class CartPage extends StatefulWidget {
  @override
  late String BrandName;
  CartPage({required this.BrandName});
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isTheCartEmpty = true;
  bool isTheRecentlyViewEmpty = true;
  bool _isLoading = true;
  bool anotherWidget = false;
  


 


  Future<bool> isRecentlyViewEmpty() async {
    User? user = _firebaseAuth.currentUser;
    var value = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('LastViewdProducts')
        .limit(1)
        .get();
  if(this.mounted){
    setState(() {
      isTheRecentlyViewEmpty = value.docs.isEmpty;
    });
  }
 
    return value.docs.isEmpty;
  }

  @override
  void initState() {
    print('hehhehe');
    super.initState();
    isRecentlyViewEmpty();
    setState(() {
      isCartEmpty();
    });
    

    //isCartEmpty();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
     Future<bool> isCartEmpty() async {
    User? user = _firebaseAuth.currentUser;
    var value = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('Cart')
        .limit(1)
        .get();
 if(this.mounted){
    setState(() {
      isTheCartEmpty = value.docs.isEmpty;
    });
 }
    return value.docs.isEmpty;
  }

  _CartPageState();
  //final CartController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    isCartEmpty();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        centerTitle: true,
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.adamina(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: _isLoading

          ? Center(child: const CircularProgressIndicator())
          : isTheCartEmpty
              ? (isTheRecentlyViewEmpty
                  ? CartCase1()
                  : CartCase2()) // Case 1 with no recent view
              : CartCase3(), // Cart is not empty
    );
    
  }

}

// Case 1: Cart is empty + continue shopping button (navigate to home page).

class CartCase1 extends StatelessWidget {
  const CartCase1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Image(
              image: ResizeImage(AssetImage('assets/images/empty-cart2.png'),
                  height: 400, width: 400)),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Cart is Empty',
              style: GoogleFonts.adamina(color: Colors.black, fontSize: 28),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FlatButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width - 20,
                  color: Color.fromARGB(70, 0, 129, 172),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (Route<dynamic> route) => false,
                    );
                    /*               Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    ); */
                  },
                  child: Text(
                    "Continue Shopping",
                    style:
                        GoogleFonts.adamina(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Case 2: Cart is empty and user has viewed some product + recently viewed + continue shopping.
class CartCase2 extends StatelessWidget {
  const CartCase2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Image(
                  image: ResizeImage(
                      AssetImage('assets/images/empty-cart2.png'),
                      height: 200,
                      width: 200)),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Cart is Empty',
                  style: GoogleFonts.adamina(color: Colors.black, fontSize: 22),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recently viewed',
                style: GoogleFonts.adamina(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          _listViewProduct(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FlatButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width - 20,
                  color: Color.fromARGB(70, 0, 129, 172),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (Route<dynamic> route) => false,
                    );
                    /*  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    ); */
                  },
                  child: Text(
                    "Continue Shopping",
                    style:
                        GoogleFonts.adamina(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
                                " SAR",
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

// Case 3: Cart not empty + checkout button. DONE :)
class CartCase3 extends StatelessWidget {
  const CartCase3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(flex: 5, child: CartProducts()),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      CartTotal(),

                      SizedBox(height: 10),
                      FlatButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width -
                            20, //double.infinity - 20,
                        color: Color.fromARGB(70, 0, 129, 172),
                        shape: RoundedRectangleBorder(
                            //side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          print('CHECKOUT');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Checkout()),
                          );
                        },
                        child: Text(
                          "CHECKOUT",
                          style: GoogleFonts.adamina(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                      //SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),

            /*  Expanded(
              //flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CartTotal(),
                    SizedBox(height: 10),
                    FlatButton(
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width -
                          20, //double.infinity - 20,
                      color: Color.fromARGB(70, 0, 129, 172),
                      shape: RoundedRectangleBorder(
                          //side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        print('CHECKOUT');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Checkout()),
                        );
                      },
                      child: Text(
                        "CHECKOUT",
                        style: GoogleFonts.adamina(
                            color: Colors.black, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ) */
          ],
        ),
      ],
    );
    
  }
  
}
