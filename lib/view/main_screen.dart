//import 'package:brandz/view/home_screen.dart';
//import 'package:brandz/view/profile_screen.dart';
//import 'package:brandz/view/search_screen.dart';

import 'package:brandz/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';
import 'Profile/profile_screen.dart';
import 'search_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomeView(),
    SearchPage(),
    CategoryPage(),
    CartPage(BrandName: ""),
    ProfilePage()
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
      if (index == 3) {
        Get.put(CartController());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //onTap: Get.put(pages[currentIndex]),
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: "Category", icon: Icon(Icons.category_sharp)),
            BottomNavigationBarItem(
                label: "Cart", icon: Icon(Icons.shopping_cart)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person))
          ]),
    );
  }
}
