import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controller/cart_controller.dart';
import '../model/product_model.dart';

class CartProducts extends StatelessWidget {
  final CartController controller = Get.find();
  CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        Positioned.fill(
          child: ListView.builder(
              shrinkWrap: false,
              itemCount: controller.products.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) => CartProductsCard(
                    controller: controller,
                    product: controller.products.keys.toList()[index],
                    //quantity: controller.products.values.toList()[index],
                    index: index,
                  )),
        ),
      ],
    );
  }
}

class CartProductsCard extends StatelessWidget {
  final CartController controller;
  final Product product;
  // final int quantity;
  final int index;

  const CartProductsCard(
      {Key? key,
      required this.controller,
      required this.product,
      //   required this.quantity,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((() => Card(
          elevation: 0,
          child: Container(
            height: 95,
            padding: const EdgeInsets.all(8.0),
            width: 100,
            margin: EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(product.imageURL)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Brand Name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          product.name + '\nSize: X',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 12)),
                        Text(
                          product.price.toString() + ' SAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("delete");
                        // open a slider to delete later! like namshi app
                        controller.removeProduct(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 50.0, bottom: 23.0),
                        child: Icon(Icons.close, color: Colors.grey[400]),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("minus");
                            controller.decreaseQuantity(product);
                          },
                          child: Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          // Quantity

                          child: Text(
                              '${controller.products.values.toList()[index]}'),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("add");
                            controller.addProduct(product);
                          },
                          child: Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
