import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_com1/view/auth/widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  final List<String> names = <String>[
    'men',
    's',
    's',
    's',
  ];

  Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget _listViewCategory() {
    return Container(
      height: 100,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade100,
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/Icon_Mens Shoe.png"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: names[index],
              )
            ],
          );
        },
        separatorBuilder: (context, int index) => SizedBox(
          width: 20,
        ),
      ),
    );
  }

  Widget _listViewProduct() {
    return Container(
      height: 100,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade100,
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        child: Image.asset("assets/images/Icon_Mens Shoe.png")),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: names[index],
              )
            ],
          );
        },
        separatorBuilder: (context, int index) => SizedBox(
          width: 20,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            _searchTextFormField(),
            SizedBox(
              height: 40,
            ),
            CustomText(
              text: 'Categories',
            ),
            _listViewCategory(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              text: "Brands",
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: ListView.separated(
                itemCount: names.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.shade100,
                        ),
                        height: 60,
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/brand2.png"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: names[index],
                      )
                    ],
                  );
                },
                separatorBuilder: (context, int index) => SizedBox(
                  width: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Best selling',
                  fontSize: 18,
                ),
                CustomText(
                  text: 'See all',
                  fontSize: 16,
                ),
              ],
            ),
            _listViewProduct(),
          ],
        ),
      ),
    );
  }
}
