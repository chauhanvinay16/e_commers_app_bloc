import 'package:e_commers_app/screen/add_product/add_product.dart';
import 'package:e_commers_app/screen/categories/categories_screen.dart';
import 'package:e_commers_app/screen/home/fav_product.dart';
import 'package:e_commers_app/screen/home/home_screen.dart';
import 'package:e_commers_app/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../helpers/color_helper.dart';


class BottemBarTabs extends StatefulWidget {
  const BottemBarTabs({super.key});

  @override
  State<BottemBarTabs> createState() => _BottemBarTabsState();
}

class _BottemBarTabsState extends State<BottemBarTabs> {

  List<Widget>screenlist=[
    const Home_screen(),
    const CategoriesScreen(),
    const add_product_screen(),
    const profile_screen(),
    FavoritesPage(),
  ];

  int currentScreen=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: currentScreen,
        children: screenlist,
      ),

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentScreen,
          onTap: (int index){
            currentScreen = index;
            setState(() {});
          },
          selectedItemColor: ColorHelper.primaryColor,
          unselectedItemColor: ColorHelper.greyColor,
          unselectedLabelStyle: const TextStyle(color: ColorHelper.greyColor),
          elevation: 10,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home), label: "Home"),


            BottomNavigationBarItem(icon: Icon(Icons.category_outlined),
                activeIcon: Icon(Icons.category), label: "categories"),

            BottomNavigationBarItem(icon: Icon(Icons.add),
                activeIcon: Icon(Icons.add), label: "Add"),

            BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp),
                activeIcon: Icon(Icons.person), label: "Profile"),

            BottomNavigationBarItem(icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite), label: "Profile"),
          ]),
    );
  }
}
