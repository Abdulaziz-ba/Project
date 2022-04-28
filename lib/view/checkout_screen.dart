import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'location_map.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String location = '';
  late TextEditingController locationController;

  Future<void> _getdata() async {
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      final llocation = userData.data()!['location'];
      //location = llocation;

      setState(() {
        location = llocation;
        locationController.text = llocation;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getdata();
    // Location Controller
    locationController = TextEditingController(text: location);
    /* locationController.addListener(() {
      final isButtonActive = locationController.text.isNotEmpty &&
          locationController.text != location;
      setState(() {});
    }); */
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    locationController.dispose();

    _controller.dispose();
  }

// Shipping Address
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          //backgroundColor: Colors.pink,

          leading: BackButton(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Checkout',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 5, // Space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color.fromARGB(255, 0, 129, 172),
                        width: 1.0, // Underline thickness
                      ))),
                      child: Text(
                        'Shipping Address',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text('Summary & Payment')
                  ],
                ),
                decoration: BoxDecoration(
                    //color: Colors.blueGrey,
                    border: Border(
                        bottom: BorderSide(
                  color: Color.fromARGB(30, 0, 0, 0),
                  width: 1,
                ))),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                //color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: location == ''
                          ? FlatButton.icon(
                              height: 60,
                              //color: Colors.amber[100],
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocationOnMap()));
                              },
                              icon: Icon(Icons.add_circle_rounded),
                              label: Text('Add A New Address'))
                          : LocationField(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              location == ''
                  ? Container()
                  : Container(
                      height: 150,
                      //color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: FlatButton.icon(
                                height: 60,
                                //color: Colors.amber[100],
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LocationOnMap()));
                                },
                                icon: Icon(Icons.update_rounded),
                                label: Text('Update Address On Map')),
                          ),
                        ],
                      ),
                    ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                          height: 80,
                          minWidth: double.infinity,
                          color: Color.fromARGB(70, 0, 129, 172),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Checkout_review_pay()),
                            );
                          },
                          child: Text('Review & Pay'))))
            ],
          ),
        ));
  }

  Container LocationField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        readOnly: true,

        controller: locationController,
        onChanged: (value) {
          setState(() {});
        },
        validator: (value) {
          return null;
        },
        onSaved: (value) {},
        autofocus: false,
        keyboardType: TextInputType.name, // change based on input
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.location_city,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: TextStyle(color: Colors.black),
          labelText: 'ADDRESS',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

// Summary & Payment
class Checkout_review_pay extends StatefulWidget {
  const Checkout_review_pay({Key? key}) : super(key: key);

  @override
  State<Checkout_review_pay> createState() => _Checkout_review_payState();
}

class _Checkout_review_payState extends State<Checkout_review_pay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          //backgroundColor: Colors.pink,
          leading: BackButton(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Checkout',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Shipping Address'),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 5, // Space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color.fromARGB(255, 0, 129, 172),
                        width: 1.0, // Underline thickness
                      ))),
                      child: Text(
                        'Summary & Payment',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    //color: Colors.blueGrey,
                    border: Border(
                        bottom: BorderSide(
                  color: Color.fromARGB(30, 0, 0, 0),
                  width: 1,
                ))),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                          height: 80,
                          minWidth: double.infinity,
                          color: Color.fromARGB(70, 0, 129, 172),
                          onPressed: () {},
                          child: Text('Buy Now'))))
            ],
          ),
        ));
  }
}
