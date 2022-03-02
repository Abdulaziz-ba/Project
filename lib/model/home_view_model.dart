import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeViewModel {
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection("Categories");
  HomeViewModel() {
    getCategory();
  }
  getCategory() async {
    _categoryCollectionRef.get().then((value) {
      print("object");
      print(value.docs[0].data());
    });
  }
}
