import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadFoods extends HomeEvent {
  const LoadFoods();
}

class ChangeCategory extends HomeEvent {
  final String category;
  const ChangeCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SearchFoods extends HomeEvent {
  final String query;
  const SearchFoods(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleFavorite extends HomeEvent {
  final String foodId;
  const ToggleFavorite(this.foodId);

  @override
  List<Object?> get props => [foodId];
}
