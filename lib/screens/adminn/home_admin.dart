import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_example/auth/auth_gate.dart';
import 'package:food_example/screens/adminn/food_list.dart';
import 'package:food_example/widgets/quick_and_fast_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/people_also_like_model.dart';
import '../../models/category_model.dart';
import '../../widgets/reuseable_text.dart';

import 'details_page.dart';
import '../../models/tab_bar_model.dart';
import '../../widgets/painter.dart';
import '../../widgets/reuseabale_middle_app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a List to store your places data
  List<TabBarModel> placesData = [];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    fetchDataFromFirestore(); // Call the method to fetch data
    super.initState();
  }

  // Add this method to fetch data from Firestore
  void fetchDataFromFirestore() async {
    try {
      // Use the 'places' collection reference (modify as per your Firestore structure)
      var snapshot = await _firestore.collection('admin').get();

      // Extract data from the snapshot
      List<TabBarModel> places = snapshot.docs.map((doc) {
        return TabBarModel(
          // Map your fields accordingly
          title:
              doc['title'] ?? '', // Provide a default value if 'title' is null
          location: doc['location'] ??
              '', // Provide a default value if 'location' is null
          image: doc['image'] ?? '',
          price: doc['price'] != null ? doc['price'].toDouble() : null,
        );
      }).toList();

      setState(() {
        placesData = places;
      });
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    }
  }

  late final TabController tabController;
  final EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 10.0);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(size),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: padding,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: const AppText(
                      text: "Welcome!",
                      size: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: const AppText(
                      text: "Admin",
                      size: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
               
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                       
                      ),
                    ),
                  ),
                   
                    const QuickAndFastListAdmin(),
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    child: Container(
                      margin: EdgeInsets.only(top: size.height * 0.01),
                      width: size.width,
                      height: size.height * 0.4,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: [
                           
                          ]),
                    ),
                  ),
                
             
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to the AddRecomendForm page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddRecommendationForm()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(Size size) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size.height * 0.09),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 5,
              ),
            child: IconButton(
              onPressed: () async {
                // Notifikasi
              //  _showLogoutConfirmationDialog(context);

                // Aksi untuk tombol sign up
                if (!mounted) return;
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthGate(),
                  ),
                );
              },
              icon: Icon(Icons.logout), // Use the logout icon here
              iconSize: 30,
              color: Colors.black,
            ),
            )
          ],
        ),
      ),
    );
  }
}


// class TabViewChild extends StatelessWidget {
//   const TabViewChild({
//     required this.list,
//     Key? key,
//   }) : super(key: key);

  // final List<TabBarModel> list;

  // @override
  // Widget build(BuildContext context) {
  //   var size = MediaQuery.of(context).size;
  //   // return ListView.builder(
  //   //   itemCount: list.length,
  //   //   physics: const BouncingScrollPhysics(),
  //   //   scrollDirection: Axis.horizontal,
  //   //   itemBuilder: (context, index) {
  //   //     TabBarModel current = list[index];
  //   //     return GestureDetector(
  //   //       onTap: () => Navigator.push(
  //   //         context,
  //   //         MaterialPageRoute(
  //   //           builder: (context) => RecipeScreenAdmin()
  //   //             personData: null,
  //   //             tabData: current,
  //   //             isCameFromPersonSection: false,
  //   //           ),
  //   //         ),
  //   //       ),
  //   //       child: Stack(
  //   //         alignment: Alignment.bottomLeft,
  //   //         children: [
  //   //           Hero(
  //   //             tag: current.image,
  //   //             child: Container(
  //   //               margin: const EdgeInsets.all(10.0),
  //   //               width: size.width * 0.6,
  //   //               decoration: BoxDecoration(
  //   //                 borderRadius: BorderRadius.circular(15),
  //   //                 image: DecorationImage(
  //   //                   image: AssetImage(current.image),
  //   //                   fit: BoxFit.cover,
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Positioned(
  //   //             bottom: 0,
  //   //             left: 0,
  //   //             right: 0,
  //   //             top: size.height * 0.2,
  //   //             child: Container(
  //   //               margin: const EdgeInsets.all(10.0),
  //   //               width: size.width * 0.53,
  //   //               height: size.height * 0.2,
  //   //               decoration: BoxDecoration(
  //   //                 borderRadius: BorderRadius.circular(15),
  //   //                 gradient: const LinearGradient(
  //   //                   colors: [
  //   //                     Color.fromARGB(153, 0, 0, 0),
  //   //                     Color.fromARGB(118, 29, 29, 29),
  //   //                     Color.fromARGB(54, 0, 0, 0),
  //   //                     Color.fromARGB(0, 0, 0, 0),
  //   //                   ],
  //   //                   begin: Alignment.bottomCenter,
  //   //                   end: Alignment.topCenter,
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Positioned(
  //   //             left: size.width * 0.07,
  //   //             bottom: size.height * 0.045,
  //   //             child: AppText(
  //   //               text: current.title,
  //   //               size: 15,
  //   //               color: Colors.white,
  //   //               fontWeight: FontWeight.w400,
  //   //             ),
  //   //           ),
  //   //           Positioned(
  //   //             left: size.width * 0.07,
  //   //             bottom: size.height * 0.025,
  //   //             child: Row(
  //   //               children: [
  //   //                 const Icon(
  //   //                   Icons.location_on,
  //   //                   color: Colors.white,
  //   //                   size: 15,
  //   //                 ),
  //   //                 SizedBox(
  //   //                   width: size.width * 0.01,
  //   //                 ),
  //   //                 AppText(
  //   //                   text: current.location,
  //   //                   size: 12,
  //   //                   color: Colors.white,
  //   //                   fontWeight: FontWeight.w400,
  //   //                 ),
  //   //               ],
  //   //             ),
  //   //           ),
  //   //         ],
  //   //       ),
  //   //     );
  //   //   },
  //   // );
  // }
//}
