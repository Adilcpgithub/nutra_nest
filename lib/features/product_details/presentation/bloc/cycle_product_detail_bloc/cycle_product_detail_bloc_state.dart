part of 'cycle_product_detail_bloc_bloc.dart';

sealed class CycleProductDetailBlocState extends Equatable {
  const CycleProductDetailBlocState();
  
  @override
  List<Object> get props => [];
}

final class CycleProductDetailBlocInitial extends CycleProductDetailBlocState {}
