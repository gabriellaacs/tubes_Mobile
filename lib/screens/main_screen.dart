import 'package:flutter/material.dart';
import 'package:food_example/constants.dart';
import 'package:food_example/screens/cart_screen.dart';
import 'package:food_example/screens/home_screen.dart';
import 'package:food_example/screens/profile_screen.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List screens = const [
    HomeScreen(),
    cart_screen(),
    profile_screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 0;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 0 ? Iconsax.home5 : Iconsax.home,
                    color: currentTab == 0 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 0 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 1;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 1 ? Iconsax.box : Iconsax.box_tick,
                    color: currentTab == 1 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 1 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 2;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 2
                        ? Iconsax.personalcard5
                        : Iconsax.personalcard,
                    color: currentTab == 2 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 2 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () => setState(() {
            //     currentTab = 3;
            //   }),
            //   child: Column(
            //     children: [
            //       Icon(
            //         currentTab == 3 ? Iconsax.people2 : Iconsax.people,
            //         color: currentTab == 3 ? Colors.black : Colors.grey,
            //       ),
            //       Text(
            //         "Profile",
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: currentTab == 3 ? kprimaryColor : Colors.grey,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
