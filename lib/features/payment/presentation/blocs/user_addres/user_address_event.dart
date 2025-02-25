part of 'user_address_bloc.dart';

class UserAddressEvent extends Equatable {
  const UserAddressEvent();

  @override
  List<Object> get props => [];
}

class LoadUserAddresses extends UserAddressEvent {
  const LoadUserAddresses();
}
