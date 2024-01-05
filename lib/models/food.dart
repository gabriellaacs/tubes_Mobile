class Food {
  String name;
  String image;
  double time;
  double rate;
  int reviews;
  bool isLiked;

  Food({
    required this.name,
    required this.image,
    required this.time,
    required this.rate,
    required this.reviews,
    required this.isLiked,
  });
}

final List<Food> foods = [
  Food(
    name: "Spicy Ramen Noodles",
    image: "assets/images/ramen-noodles.jpg",
    time: 15,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
  Food(
    name: "Latte",
    image: "assets/images/coffee1.jpg",
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: true,
  ),
  Food(
    name: "Americano",
    image: "assets/images/coffee2.jpg",
    time: 18,
    rate: 4.2,
    reviews: 10,
    isLiked: false,
  ),
  Food(
    name: "French Toast",
    image: "assets/images/french-toast.jpg",
    time: 16,
    rate: 4.6,
    reviews: 90,
    isLiked: true,
  ),
  Food(
    name: "Cappucino",
    image: "assets/images/coffee4.jpg",
    time: 30,
    rate: 4.0,
    reviews: 76,
    isLiked: false,
  ),
  Food(
    name: "Milk Coffee",
    image: "assets/images/coffee3.jpg",
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
];
