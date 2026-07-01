class FoodItem {
 
  final String title;
  final String subtitle;
  final String image;
  final double rating;
  final bool isFavorite;
  final String category;

  const FoodItem({
   
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    this.isFavorite = false,
    required this.category, 
  });

  FoodItem copyWith({bool? isFavorite}) {
    return FoodItem(
    
      title: title,
      subtitle: subtitle,
      image: image,
      rating: rating,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category,
    );
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
    
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      image: json['image'] ?? '', 
      rating: (json['rating'] ?? 0).toDouble(),
      isFavorite: json['is_favorite'] ?? false,
      category: json['category'] ?? 'All',
    );
  }
}
