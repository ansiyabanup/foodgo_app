import 'package:flutter_test/flutter_test.dart';
import 'package:foodgo_app_test/repositories/food_repository.dart';

void main() {
  test(
    'fetchFoods returns offline mock items when no backend is available',
    () async {
      final repository = FoodRepository();

      final foods = await repository.fetchFoods();

      expect(foods, isNotEmpty);
      expect(foods.first.title, isNotEmpty);
    },
  );
}
