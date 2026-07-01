import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/food_item.dart';
import '../../repositories/food_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodRepository foodRepository;

  HomeBloc({required this.foodRepository}) : super(const HomeState()) {
    on<LoadFoods>(_onLoadFoods);
    on<ChangeCategory>(_onChangeCategory);
    on<SearchFoods>(_onSearchFoods);
   // on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFoods(LoadFoods event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final foods = await foodRepository.fetchFoods();
      emit(state.copyWith(
        status: HomeStatus.success,
        foods: foods,
        filteredFoods: foods,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChangeCategory(
      ChangeCategory event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      selectedCategory: event.category,
      status: HomeStatus.loading,
    ));
    try {
      final foods = await foodRepository.fetchFoods(category: event.category);
      emit(state.copyWith(
        status: HomeStatus.success,
        foods: foods,
        filteredFoods: _applySearch(foods, state.searchQuery),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSearchFoods(SearchFoods event, Emitter<HomeState> emit) {
    final filtered = _applySearch(state.foods, event.query);
    emit(state.copyWith(searchQuery: event.query, filteredFoods: filtered));
  }

  // Future<void> _onToggleFavorite(
  //     ToggleFavorite event, Emitter<HomeState> emit) async {
  //   final updatedFoods = state.foods
  //       .map((food) => food.id == event.foodId
  //           ? food.copyWith(isFavorite: !food.isFavorite)
  //           : food)
  //       .toList();

  //   final updatedFiltered = state.filteredFoods
  //       .map((food) => food.id == event.foodId
  //           ? food.copyWith(isFavorite: !food.isFavorite)
  //           : food)
  //       .toList();

  //   emit(state.copyWith(foods: updatedFoods, filteredFoods: updatedFiltered));

  //   final toggled = updatedFoods.firstWhere((f) => f.id == event.foodId);
  //   await foodRepository.toggleFavorite(event.foodId, toggled.isFavorite);
  // }

  List<FoodItem> _applySearch(List<FoodItem> foods, String query) {
    if (query.isEmpty) return foods;
    final q = query.toLowerCase();
    return foods
        .where((f) =>
            f.title.toLowerCase().contains(q) ||
            f.subtitle.toLowerCase().contains(q))
        .toList();
  }
}
