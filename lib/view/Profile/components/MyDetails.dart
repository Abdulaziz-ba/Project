// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:brandz/view/Profile/components/body.dart';

class MyDetails extends StatefulWidget {
  MyDetails({Key? key}) : super(key: key);

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  // Global
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String fname = '';
  String lname = '';
  String email = '';
  String phone = '';
  String location = '';

  bool isButtonActive = false;
  bool isValidMail = false;

  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  // get user data
  void _getdata() async {
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      final ffname = userData.data()!['FirstName'];
      final llname = userData.data()!['LastName'];
      final eemail = userData.data()!['email'];
      final pphone = userData.data()!['phone'];
      final llocation = userData.data()!['location'];

      print('ffname:' + ffname);

      this.fname = ffname;
      this.lname = llname;
      this.email = eemail;
      this.phone = pphone;
      this.location = llocation;

      setState(() {
        fNameController.text = ffname;
        print('setstate - fnameController:' + fNameController.text);
        lNameController.text = llname;
        emailController.text = eemail;
        phoneController.text = pphone;
        locationController.text = llocation;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getdata();

    print('done geting data');
    // FirstName Controller
    fNameController = TextEditingController(text: fname);
    print('fNameController.text:' + fNameController.text);
    fNameController.addListener(() {
      final isButtonActive =
          fNameController.text.isNotEmpty && fNameController.text != fname;
      setState(() => this.isButtonActive = isButtonActive);
    });

    // LastName Controller
    lNameController = TextEditingController(text: lname);
    lNameController.addListener(() {
      final isButtonActive =
          lNameController.text.isNotEmpty && lNameController.text != lname;
      setState(() => this.isButtonActive = isButtonActive);
    });

    // Email Controller
    emailController = TextEditingController(text: email);
    emailController.addListener(() {
      final isButtonActive =
          emailController.text.isNotEmpty && emailController.text != email;
      setState(() => this.isButtonActive = isButtonActive);
    });

    // Phone Controller
    phoneController = TextEditingController(text: phone);
    phoneController.addListener(() {
      final isButtonActive =
          phoneController.text.isNotEmpty && phoneController.text != phone;
      setState(() => this.isButtonActive = isButtonActive);
    });

    // Location Controller
    locationController = TextEditingController(text: location);
    locationController.addListener(() {
      final isButtonActive = locationController.text.isNotEmpty &&
          locationController.text != location;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          'My Details',
          style: GoogleFonts.adamina(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      // all above been checked!
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FirstNameField(),
                    LastNameField(),
                    EmailField(),
                    PhoneField(),
                    LocationField(),
                    ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.black87),
                        onPressed: isButtonActive
                            ? () {
                                Update();
                              }
                            : null,
                        child: Text('SAVE CHANGES'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void Update() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('valid');
      final docUser = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid);

      // Update
      docUser.update({
        'FirstName': fNameController.text,
        'LastName': lNameController.text,
        'email': email,
        'phone': phoneController.text,
        'location': locationController.text,
      });
      setState(() => isButtonActive = false);
    }
  }

  Container LocationField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: locationController,
        onChanged: (value) {
          setState(() {
            value != location
                ? isButtonActive == true
                : isButtonActive == false;
          });
        },
        validator: (value) {
          print('validating');
          // no validation yet
        },
        onSaved: (value) {
          print('saved');
        },
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

  Container PhoneField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: phoneController,
        onChanged: (value) {
          setState(() {
            value != phone ? isButtonActive == true : isButtonActive == false;
          });
        },
        validator: (value) {
          print('validating');
          RegExp regex = new RegExp(r'^(05)\d{8}$');
          if (value == null || value.isEmpty || !regex.hasMatch(value)) {
            return 'Enter a valid phone number (e.g. 05XXXXXXXX)';
          } else {
            print('phone is good :)');
          }
        },
        onSaved: (value) {
          print('saved');
        },
        autofocus: false,
        keyboardType: TextInputType.name, // change based on input
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: TextStyle(color: Colors.black),
          labelText: 'Phone Number',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Container EmailField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: emailController,
        onChanged: (value) {
          setState(() {
            isValidMail ? email = value : null;
          });
        },
        autofocus: false,
        keyboardType: TextInputType.emailAddress, // change based on input
        validator: (value) {
          RegExp regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
          if (value == null || value.isEmpty || !regex.hasMatch(value)) {
            return 'Enter a valid email address';
          } else {
            setState(() {
              value != email ? isValidMail = true : isValidMail = false;
              isValidMail ? email = value : null;
            });
          }
          return null;
        },
        onSaved: (value) {
          print('saved');
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: TextStyle(color: Colors.black),
          labelText: 'Email',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Container LastNameField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: lNameController,
        onChanged: (value) {
          setState(() {
            value != lname ? isButtonActive == true : isButtonActive == false;
          });
        },
        validator: (value) {
          print('validating');
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) return ("Last Name cannot be Empty!");
          if (!regex.hasMatch(value))
            return ("Enter a valid name (Min: 3 character)");
        },
        onSaved: (value) {
          print('saved');
        },
        autofocus: false,
        keyboardType: TextInputType.name, // change based on input
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.face,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: TextStyle(color: Colors.black),
          labelText: 'Last Name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Container FirstNameField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: fNameController,
        onChanged: (value) {
          setState(() {
            print(value); // debug
            value != fname ? isButtonActive == true : isButtonActive == false;
          });
          print('chaged!');
        },
        validator: (value) {
          print('validating');
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) return ("First Name cannot be Empty!");
          if (!regex.hasMatch(value))
            return ("Enter a valid name (Min: 3 character)");
        },
        onSaved: (value) {
          print('saved');
        },
        autofocus: false,
        keyboardType: TextInputType.name, // change based on input
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.face,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: TextStyle(color: Colors.black),
          labelText: 'First Name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
