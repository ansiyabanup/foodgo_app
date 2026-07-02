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




