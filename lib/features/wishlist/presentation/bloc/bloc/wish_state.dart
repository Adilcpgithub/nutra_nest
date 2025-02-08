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

class WishDataAddSuccessful extends WishState {
  final String message;
  final bool isNewMessage;
  const WishDataAddSuccessful(
      {required super.wishItems,
      required this.message,
      required this.isNewMessage});
  @override
  List<Object> get props => [message];
}

class WishDataAddingFailed extends WishState {
  final String message;
  final bool isNewFailed;
  const WishDataAddingFailed(
      {required super.wishItems,
      required this.message,
      required this.isNewFailed});
}
