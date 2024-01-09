import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_example/constants.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/screens/cart_screen.dart';
import 'package:food_example/widgets/food_counter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:food_example/widgets/cart_state.dart';

class RecipeScreen extends StatefulWidget {
  final Food food;
  const RecipeScreen({Key? key, required this.food}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  int currentNumber = 1;
  // static List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    print('Food Details:');
    print('Name: ${widget.food.name}');
    print('Picture URL: ${widget.food.pictureUrl}');
    print('Description: ${widget.food.description}');
    print('Location: ${widget.food.location}');
    print('Price: ${widget.food.price}');
    print('Rating: ${widget.food.rating}');

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: ElevatedButton(  
                onPressed: () {
                  // Call a function to add the item to the favorite list
                  addToFavorite(widget.food.name, widget.food.price);

                  // Navigate to the favorite page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Add to favorite"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                ),
                icon: Icon(
                  widget.food.isLiked ? Iconsax.location : Iconsax.location,
                  color: widget.food.isLiked
                      ? Colors.red
                      : const Color.fromARGB(255, 167, 158, 158),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                            widget.food.pictureUrl), // Fix this line
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size(50, 50),
                        ),
                        icon: const Icon(CupertinoIcons.chevron_back),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size(50, 50),
                        ),
                        icon: const Icon(Iconsax.notification),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    // Additional details can be added here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.food.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.food.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Location: ${widget.food.location}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Price: \$${widget.food.price}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // const Icon(
                      //   Iconsax.clock,
                      //   size: 20,
                      //   color: Colors.grey,
                      // ),
                      Text(
                        "Rp. ${widget.food.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Iconsax.star5,
                        color: Colors.yellow.shade700,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.food.rating}/5",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Text(
                      //   "(${widget.food.description} Reviews)",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey.shade400,
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.food.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 void addToFavorite(String name, double price) {
    setState(() {
      // Add the item to the favorite list
      CartState.cartItems.add({'name': name, 'price': price});
    });
  }
}

