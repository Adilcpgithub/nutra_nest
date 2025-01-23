part of 'wish_bloc.dart';

class WishState extends Equatable {
  final List<WishModel> wishItems;
  const WishState({required this.wishItems});

  WishState copyWith({List<WishModel>? wishItems}) {
    return WishState(
      wishItems: wishItems ?? this.wishItems,
    );
  }

  @override
  List<Object> get props => [wishItems];
}

class WishLoading extends WishState {
  const WishLoading({required super.wishItems});
}

class WishLoaded extends WishState {
  const WishLoaded({required super.wishItems});
}
