import 'package:equatable/equatable.dart';
import '../../models/food_item.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<FoodItem> foods;
  final List<FoodItem> filteredFoods;
  final String selectedCategory;
  final String searchQuery;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.foods = const [],
    this.filteredFoods = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<FoodItem>? foods,
    List<FoodItem>? filteredFoods,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      foods: foods ?? this.foods,
      filteredFoods: filteredFoods ?? this.filteredFoods,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        foods,
        filteredFoods,
        selectedCategory,
        searchQuery,
        errorMessage,
      ];
}
