import '../models/food_item.dart';


class FoodRepository {
  FoodRepository();

  Future<List<FoodItem>> fetchFoods({String category = 'All'}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _mockFoods(category);
  }

  Future<void> toggleFavorite(String foodId, bool isFavorite) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  List<FoodItem> _mockFoods(String category) {
    final all = [
      const FoodItem(
        title: 'Cheeseburger',
        subtitle: "Wendy's Burger",
        image: 'assets/images/cheeseburger.png',
        rating: 4.9,
        category: 'Combos',
      ),
      const FoodItem(
        title: 'Hamburger',
        subtitle: 'Veggie Burger',
        image: 'assets/images/Hamburger_veggie.png',
        rating: 4.8,
        category: 'Sliders',
      ),
      const FoodItem(
        title: 'Hamburger',
        subtitle: 'Chicken Burger',
        image: 'assets/images/hamburger_chicken.png',
        rating: 4.6,
        category: 'Classics',
      ),
      const FoodItem(
        title: 'Hamburger',
        subtitle: 'Fried Chicken Burger',
        image: 'assets/images/hamburger_fried.png',
        rating: 4.5,
        category: 'Combos',
      ),
    ];

    if (category == 'All') return all;
    return all.where((food) => food.category == category).toList();
  }
}
