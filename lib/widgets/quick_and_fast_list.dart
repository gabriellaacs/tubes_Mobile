import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/screens/quick_foods_screen.dart';
import 'package:food_example/screens/recipe_screen.dart';
import 'package:iconsax/iconsax.dart';

class QuickAndFastList extends StatelessWidget {
  const QuickAndFastList({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Food> foods;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Quick & Fast",
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
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('admin')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            foods = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return Food.fromMap(data);
            }).toList();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  
                  foods.length,
                  (index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeScreen(food: foods[index]),
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
                                    image: NetworkImage(foods[index]
                                        .pictureUrl), // Assuming 'image' is a URL
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                foods[index].name,
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
                                    "Rp. ${foods[index].price}",
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
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(30, 30),
                              ),
                              iconSize: 20,
                              icon: const Icon(Iconsax.heart),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
