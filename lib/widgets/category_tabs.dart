import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selected;
          return GestureDetector(
            onTap: () => onSelected(category),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25),

              decoration: BoxDecoration(
                boxShadow: (isSelected)
                    ? [
                        BoxShadow(
                          color: const Color(0x00000040).withOpacity(0.1),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                          spreadRadius: -1,
                        ),
                      ]
                    : [],
                color: isSelected
                    ? const Color(0xFFFFC529)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
