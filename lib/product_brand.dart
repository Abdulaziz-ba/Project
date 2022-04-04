import 'package:brandz/model/custom_text.dart';
import 'package:brandz/model/list_of_products.dart';
import 'package:brandz/view/cart_screen.dart';
import 'package:brandz/view/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:brandz/widgets/cart_products.dart';
import "package:brandz/controller/cart_controller.dart";
import 'model/product_model.dart';
import 'model/user_model.dart';

var data;
 late List<Image> imageList;
  late List<String> nameList;
  late List<int> priceList;
class product_brand extends StatelessWidget {
  String id;
  late String displayBrand;
 
  product_brand({required this.id});
  @override
  Widget build(BuildContext context) {  
    final Stream<QuerySnapshot> brands = FirebaseFirestore.instance.collection('Products')
            .where('parentId', isEqualTo : id).snapshots();
            
    return Scaffold(
       backgroundColor: Colors.white,
     appBar: AppBar(
       elevation: 0.0,
               backgroundColor: Colors.white,

       leading: BackButton(color: Colors.black),
    
       
      ),
     body: SafeArea(
       child: StreamBuilder(
         stream: brands ,
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
              return Text("first if");
            }
            if (snapshot.hasError) {
              return Text("There is an error");
            }
             data = snapshot.requireData;
            
            
            return Expanded(
              child: Container(
               padding: EdgeInsets.all(10.0),
              child: GridView.builder(
              itemCount: data.size,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0), 
              scrollDirection: Axis.vertical,
              
              itemBuilder: (context, index) {
                return ProductCard(index: index);
              }
               )) );
         }
         
       
       
          ),



   ));
      
      
    
  }
}class ProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
    final _auth = FirebaseAuth.instance;

  final int index;
  ProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('product index $index');
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_productBox(index)]),
    );
  }

  Widget _productBox(int index) {
    return Container(
      child: Column(
        children: [        
           Text(data.docs[index]['name']),
           
           
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(data.docs[index]['price']+ ' SAR'),
                 IconButton(
                  onPressed: () {
                    
                   User? user = _auth.currentUser;
                   UserModel userModel = UserModel();
                   String Brand = data.docs[index]['name'].toString();
                    var noteInfo = data!.docs[index].data()! as Map;
                    var object = Product(imageURL: noteInfo['image'], name: noteInfo['name'], 
                    price: double.parse(noteInfo['price']) , brandName: noteInfo['BrandName'] , quantitiy: 1);
                    // add product to cart
                  cartController.addProduct(object , user);
                     
                  },
                  
                  icon: Icon(Icons.shopping_cart_checkout_rounded))
            
            ],
          ),
           Image.network(
          data.docs[index]['image'],
          width: 100,
          height: 100,
         ),
          
           
          
        ],
      ),
    );
  }
  
}


