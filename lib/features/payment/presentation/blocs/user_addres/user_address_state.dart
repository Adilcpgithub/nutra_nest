part of 'user_address_bloc.dart';

class UserAddressState extends Equatable {
  const UserAddressState();

  @override
  List<Object> get props => [];
}

class UserAddressLoading extends UserAddressState {}

class UserAddressLoaded extends UserAddressState {
  final Map<String, dynamic> selectedAddress;

  const UserAddressLoaded({required this.selectedAddress});

  @override
  List<Object> get props => [selectedAddress];
}

class UserAddressError extends UserAddressState {
  final String message;

  const UserAddressError({required this.message});

  @override
  List<Object> get props => [message];
}
