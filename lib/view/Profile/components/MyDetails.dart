import 'package:brandz/view/Profile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDetails extends StatelessWidget {
  const MyDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black),
          centerTitle: true,
          title:
              const Text('MY DETAILS', style: TextStyle(color: Colors.black)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            displayBox2(
                hintText: 'BASSEM',
                lableText: 'FIRST NAME',
                icon: Icon(
                  Icons.face,
                )),
            displayBox2(
                hintText: 'ALOTAIG',
                lableText: 'LAST NAME',
                icon: Icon(
                  Icons.face,
                )),
            displayBox2(
                hintText: 'Bassem@gmail.com',
                lableText: 'EMAIL ADDRESS',
                icon: Icon(
                  Icons.mail,
                )),
            displayBox2(
                hintText: '0557701594',
                lableText: 'PHONE NUMBER',
                icon: Icon(
                  Icons.phone,
                )),
            displayBox2(
                hintText: 'RIYADH, ALHAMRA',
                lableText: 'ADDRESS',
                icon: Icon(
                  Icons.location_city,
                ))
          ],
        ));
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
