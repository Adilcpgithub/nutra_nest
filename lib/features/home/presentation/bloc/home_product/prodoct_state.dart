part of 'prodoct_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Cycle> cycles;
  final Set<String> favorites;

  const ProductLoadedState(this.cycles, {this.favorites = const {}});
  @override
  List<Object> get props => [cycles, favorites];
}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {
  final String error;
  const ProductError(this.error);
}
