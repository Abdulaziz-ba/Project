import '../model/product_model.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class ListOfProducts extends StatelessWidget {
  const ListOfProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: Product.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(index: index);
            },
          )),
    );
  }
}

class ProductCard extends StatelessWidget {
  //final cartController = Get.put(CartController());
  final int index;
  ProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_productBox(index)]),
    );
  }

  Widget _productBox(int index) {
    return Container(
      //color: Colors.grey,
      child: Column(
        children: [
          Image(
           image: CachedNetworkImageProvider(Product.products[index].imageURL),
           height: 100,
            //width: 100,
          ),
          
          Text(Product.products[index].name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Product.products[index].price.toString() + ' SAR'),
              IconButton(
                  onPressed: () {
                    // add product to cart
                    //cartController.addProduct(Product.products[index]);
                  },
                  icon: Icon(Icons.add))
            ],
          )
        ],
      ),
    );
  }
}
