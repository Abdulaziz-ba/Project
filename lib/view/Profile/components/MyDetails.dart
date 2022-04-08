import 'package:brandz/view/Profile/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDetails extends StatelessWidget {
  MyDetails({Key? key}) : super(key: key);

  final userData = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  var data;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("first if");
              }
              if (snapshot.hasError) {
                return Text("There is an error");
              }
              data = snapshot.requireData;

              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    leading: BackButton(color: Colors.black),
                    centerTitle: true,
                    title: const Text('MY DETAILS',
                        style: TextStyle(color: Colors.black)),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      displayBox2(
                          hintText: data['FirstName'],
                          lableText: 'FIRST NAME',
                          icon: Icon(
                            Icons.face,
                          )),
                      displayBox2(
                          hintText: data['LastName'],
                          lableText: 'LAST NAME',
                          icon: Icon(
                            Icons.face,
                          )),
                      displayBox2(
                          hintText: data['email'],
                          lableText: 'EMAIL ADDRESS',
                          icon: Icon(
                            Icons.mail,
                          )),
                      displayBox2(
                          hintText: 'add new phone number', //data['phone']
                          lableText: 'PHONE NUMBER',
                          icon: Icon(
                            Icons.phone,
                          )),
                      displayBox2(
                          hintText: 'add new location', //data['location']
                          lableText: 'ADDRESS',
                          icon: Icon(
                            Icons.location_city,
                          ))
                    ],
                  ));
            }));
  }
}

class displayBox2 extends StatelessWidget {
  const displayBox2({
    Key? key,
    required this.hintText,
    required this.lableText,
    required this.icon,
  }) : super(key: key);

  final String hintText;
  final String lableText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        readOnly: true,
        enabled: true,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: icon,
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          labelText: lableText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
