part of 'prodoct_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetAllPoduct extends ProductEvent {
  final String searchQuery;
  const GetAllPoduct(this.searchQuery);
}

class ProductInitialEvent extends ProductEvent {}
