class Food {
  String name;
  String description;
  String location;
  double rating;
  double price;
  bool isLiked;
  String pictureUrl; // Add this field

  Food({
    required this.name,
    required this.description,
    required this.location,
    required this.rating,
    required this.price,
    required this.isLiked,
    required this.pictureUrl,
  });

  // Factory method to create a Food object from a map
  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['destinationName'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : 0.0,
      price: map['price'] != null ? (map['price'] as num).toDouble() : 0.0,
      isLiked: false, // You may need to adjust this based on your data
      pictureUrl: map['pictureUrl'] ?? '', // Use the correct field name
    );
  }
}


// final List<Food> foods = [
//   Food(
//     name: "Spicy Ramen Noodles",
//     image: "assets/images/ramen-noodles.jpg",
//     time: 15,
//     rate: 4.4,
//     reviews: 23,
//     isLiked: false,
//   ),
//   Food(
//     name: "Latte",
//     image: "assets/images/coffee1.jpg",
//     time: 25,
//     rate: 4.4,
//     reviews: 23,
//     isLiked: true,
//   ),
//   Food(
//     name: "Americano",
//     image: "assets/images/coffee2.jpg",
//     time: 18,
//     rate: 4.2,
//     reviews: 10,
//     isLiked: false,
//   ),
//   Food(
//     name: "French Toast",
//     image: "assets/images/french-toast.jpg",
//     time: 16,
//     rate: 4.6,
//     reviews: 90,
//     isLiked: true,
//   ),
//   Food(
//     name: "Cappucino",
//     image: "assets/images/coffee4.jpg",
//     time: 30,
//     rate: 4.0,
//     reviews: 76,
//     isLiked: false,
//   ),
//   Food(
//     name: "Milk Coffee",
//     image: "assets/images/coffee3.jpg",
//     time: 25,
//     rate: 4.4,
//     reviews: 23,
//     isLiked: false,
//   ),
// ];
