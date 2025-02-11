part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

// Loading state
class AddressLoading extends AddressState {}

// Loaded state
class AddressLoaded extends AddressState {
  final List<Map<String, dynamic>> addresses;
  final String selectedAddressId;

  const AddressLoaded(
      {required this.addresses, required this.selectedAddressId});

  @override
  List<Object> get props => [addresses, selectedAddressId];
}

// Error state
class AddressError extends AddressState {
  final String message;

  const AddressError(
    this.message,
  );

  @override
  List<Object> get props => [message];
}

class AddAddressSuccess extends AddressState {
  final bool isNew;
  const AddAddressSuccess(this.isNew);
}

class UpdatedAddressSuccess extends AddressState {
  final bool isNew;
  const UpdatedAddressSuccess(this.isNew);
  @override
  List<Object> get props => [isNew];
}

class AddressDeletionSuccess extends AddressState {
  final bool isNew;
  const AddressDeletionSuccess(this.isNew);
  @override
  List<Object> get props => [isNew];
}
