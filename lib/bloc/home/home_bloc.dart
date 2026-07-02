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
  }

  Future<void> _onLoadFoods(LoadFoods event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final foods = await foodRepository.fetchFoods();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          foods: foods,
          filteredFoods: foods,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onChangeCategory(
    ChangeCategory event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategory: event.category,
        status: HomeStatus.loading,
      ),
    );
  }
}
