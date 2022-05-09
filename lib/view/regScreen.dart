// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// Project imports:
import '../model/user_model.dart';
import 'auth/login_screen.dart';

class reg_screen extends StatefulWidget {
  const reg_screen({Key? key}) : super(key: key);
  @override
  _reg_screenState createState() => _reg_screenState();
}

class _reg_screenState extends State<reg_screen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  // Editing Controller
  final TextEditingController fNameController = new TextEditingController();
  final TextEditingController lNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController conpasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //FName Field
    final FnameField = TextFormField(
      autofocus: false,
      controller: fNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) return ("signUp1".tr);
        if (!regex.hasMatch(value))
          return ("signUp2".tr);
      },
      onSaved: (value) {
        fNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.face,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "signUp3".tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //LName Field
    final LnameField = TextFormField(
      autofocus: false,
      controller: lNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) return ("signUp4".tr);
        if (!regex.hasMatch(value))
          return ("signUp5".tr);
        return null;
      },
      onSaved: (value) {
        lNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.face,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "signUp6".tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ); //Email Field
    //Email Field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("signUp7".tr);
        }
        //This is a Regex for the email Valdiation ==> (Valid Email or Not)
        if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
          return ("signUp8".tr);
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "signUp9".tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ); //fName Field
    //Phone Field
    final PhoneField = TextFormField(
      autofocus: false,
      controller: phoneController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^(05)\d{8}$');
        if (value!.isEmpty) return ("signUp10".tr);
        if (!regex.hasMatch(value))
          return ("signUp11".tr);
      },
      onSaved: (value) {
        phoneController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "signUp12".tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //Password Field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) return ("signUp13".tr);
        if (!regex.hasMatch(value))
          return ("signUp14".tr);
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "signUp15".tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //conpassword Field
    final conpasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: conpasswordController,
      validator: (value) {
        if (conpasswordController.text.length > 6 &&
            conpasswordController.text != value) {
          return ("signUp16".tr);
        }
        return null;
      },
      onSaved: (value) {
        conpasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "signUp17".tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //SignUp Buutn
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailController.text, passwordController.text);
          },
          child: Text(
            "signUp18".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //were we add our UI components
                  children: <Widget>[
                    //logo in the middle
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/logo_size.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    FnameField,

                    SizedBox(
                      height: 15,
                    ),
                    LnameField,

                    SizedBox(
                      height: 15,
                    ),
                    emailField,
                    SizedBox(
                      height: 15,
                    ),
                    PhoneField,
                    SizedBox(
                      height: 15,
                    ),

                    passwordField,
                    SizedBox(
                      height: 15,
                    ),
                    conpasswordField,
                    SizedBox(
                      height: 30,
                    ),
                    signUpButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirebase()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirebase() async {
    //calling our Firebase
    // calling our user model
    //sending their values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    //writing all the values
    userModel.FirstName = fNameController.text;
    userModel.LastName = lNameController.text;
    userModel.email = user!.email;
    userModel.phone = phoneController.text;
    userModel.location =
        ''; // added an empty field for location when new user signup

    userModel.uid = user.uid;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully 🙂 ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
