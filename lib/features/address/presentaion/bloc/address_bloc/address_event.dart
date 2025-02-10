part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class LoadAddresses extends AddressEvent {
  //const LoadAddresses(this.);
}

// Add a new address
class AddAddress extends AddressEvent {
  final Map<String, dynamic> newAddress;
  const AddAddress(this.newAddress);
}

// Select an address as default
class SelectAddress extends AddressEvent {
  final String addressId;
  const SelectAddress(this.addressId);
}

// Delete an address
class DeleteAddress extends AddressEvent {
  final String addressId;
  const DeleteAddress(this.addressId);
}

class EditAddress extends AddressEvent {
  final String addressId;
  final AddressModel addressModel;
  const EditAddress(this.addressId, this.addressModel);
}
