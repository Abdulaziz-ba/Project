import 'package:brandz/brand_Category.dart';
import 'package:brandz/product_brand.dart';
import 'package:brandz/view/auth/login_screen.dart';
import 'package:brandz/view/home_screen.dart';
import 'package:brandz/view/regScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Product {
  late final String name;
  late final double price;
  late final String imageURL;
  late final String brandName;
  late final int quantitiy;
  late final String description;
  Product({
    required this.name,
    required this.price,
    required this.imageURL,
    required this.brandName,
    required this.quantitiy,
    required this.description
  });

static List<Product> products = <Product>[

];




}  

