import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/screens/adminn/details_page.dart';
import 'package:food_example/screens/quick_foods_screen.dart';
import 'package:food_example/screens/recipe_screen.dart';
import 'package:iconsax/iconsax.dart';

class QuickAndFastListAdmin extends StatefulWidget {
  const QuickAndFastListAdmin({Key? key}) : super(key: key);

  @override
  _QuickAndFastListAdminState createState() => _QuickAndFastListAdminState();
}

class _QuickAndFastListAdminState extends State<QuickAndFastListAdmin> {
  // Add a list to store the recommended places
  List<Map<String, dynamic>> recommendedPlaces = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRecommendedPlacesData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Update the list of recommended places
          recommendedPlaces = snapshot.data as List<Map<String, dynamic>>;

          return RefreshIndicator(
            onRefresh: () async {
              // Refresh the data
              setState(() {});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommend Food",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuickFoodsScreen(),
                        ),
                      ),
                      child: const Text("View all"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      recommendedPlaces.length,
                      (index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeScreenAdmin(
                              food: Food.fromMap(recommendedPlaces[index]),
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 200,
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 130,
                                    decoration: BoxDecoration(
                                     
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          recommendedPlaces[index]['image'],
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    recommendedPlaces[index]['destinationName'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Iconsax.clock,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "Rp. ${recommendedPlaces[index]['rating']}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                top: 1,
                                right: 1,
                                child: IconButton(
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        context, recommendedPlaces[index]);
                                  },
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    fixedSize: const Size(30, 30),
                                  ),
                                  iconSize: 20,
                                  icon: const Icon(Iconsax.trash),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, dynamic> place) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete ${place['destinationName']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deletePlace(context, place);
                Navigator.of(context).pop(); // Close the dialog
                setState(() {}); // Reload the data after deletion
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePlace(
      BuildContext context, Map<String, dynamic> place) async {
    // Delete from Firestore
    try {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(place['documentId'])
          .delete();
    } catch (error) {
      print('Error deleting place: $error');
    }
  }

  Future<List<Map<String, dynamic>>> _getRecommendedPlacesData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('admin').get();

      List<Map<String, dynamic>> recommendedPlaces = [];

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        recommendedPlaces.add({
          'documentId': documentSnapshot.id,
          'image': data['pictureUrl'],
          'destinationName': data['destinationName'],
          'location': data['location'],
          'rating': data['rating'],
        });
      }

      return recommendedPlaces;
    } catch (error) {
      print('Error getting recommended places data: $error');
      return [];
    }
  }
}
