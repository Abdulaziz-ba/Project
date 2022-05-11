//import 'package:brandz/view/home_screen.dart';
//import 'package:brandz/view/profile_screen.dart';
//import 'package:brandz/view/search_screen.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../controller/cart_controller.dart';
import '../view/compare_screen.dart';
import 'Profile/profile_screen.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomeView(),
    ComparePage(),
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
   /* if(currentIndex == 3){
      onTap(3);
    }*/
    Get.put(CartController());
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: buildBottomNavigation(),
    );
  }
  Widget buildBottomNavigation(){
    
    final inactivecolor = Colors.grey; 
    return BottomNavyBar(
      
      backgroundColor: Colors.white,
      selectedIndex: currentIndex,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          inactiveColor: inactivecolor,
          activeColor: Colors.green,
          textAlign: TextAlign.center
        ),
          BottomNavyBarItem(
          icon: Icon(Icons.compare),
          title: Text('Compare items'),
          inactiveColor: inactivecolor,
          activeColor: Colors.red,
          textAlign: TextAlign.center
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.category_sharp),
          title: Text('Categories'),
          inactiveColor: inactivecolor,
          activeColor: Colors.blue,
          textAlign: TextAlign.center
        ),
           BottomNavyBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Cart'),
          inactiveColor: inactivecolor,
          activeColor: Colors.yellow,
          textAlign: TextAlign.center
        ),
         BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          inactiveColor: inactivecolor,
          activeColor: Colors.orange,
          textAlign: TextAlign.center
        ),
    ] 
    ,
     onItemSelected: (index) => setState(() {
       this.currentIndex = index;
     })
     
     
     );

  }
}
