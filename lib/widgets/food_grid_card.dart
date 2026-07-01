import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodGridCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onFavoriteTap;

  const FoodGridCard({
    super.key,
    required this.food,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: Color(0x21000000),
            blurRadius: 17,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(food.image),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            food.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Text(
            food.subtitle,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFC529), size: 18),
                  const SizedBox(width: 4),
                  Text(food.rating.toString()),
                ],
              ),
              Image.asset(
                'assets/images/favourite.png',
                color: Color(0xFF3C2F2F),

                width: 24,
                height: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
