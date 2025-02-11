part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class LoadAddresses extends AddressEvent {}

// Add a new address
class AddAddress extends AddressEvent {
  final Map<String, dynamic> newAddress;
  const AddAddress(this.newAddress);
  @override
  List<Object> get props => [newAddress];
}

// Select an address as default
class SelectAddress extends AddressEvent {
  final String addressId;
  const SelectAddress(this.addressId);
  @override
  List<Object> get props => [addressId];
}

// Delete an address
class DeleteAddress extends AddressEvent {
  final String addressId;
  const DeleteAddress(this.addressId);
  @override
  List<Object> get props => [addressId];
}

class EditAddress extends AddressEvent {
  final String addressId;
  final AddressModel addressModel;
  const EditAddress(this.addressId, this.addressModel);
  @override
  List<Object> get props => [addressId, addressModel];
}
