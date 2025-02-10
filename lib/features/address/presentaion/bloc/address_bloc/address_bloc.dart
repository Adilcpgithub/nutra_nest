import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/features/address/data/models/address_model.dart';
import 'package:uuid/uuid.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserStatus userStatus = UserStatus();

  AddressBloc() : super(AddressInitial()) {
    on<LoadAddresses>(_onLoadAddresses);
    on<AddAddress>(_onAddAddress);
    on<SelectAddress>(_onSelectAddress);
    on<DeleteAddress>(_onDeleteAddress);
    on<EditAddress>(_onEditAddress);
  }

  // Load Addresses
  Future<void> _onLoadAddresses(
      LoadAddresses event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final userId = await userStatus.getUserId();
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(userId).get();

      if (!userDoc.exists || userDoc.data() == null) {
        emit(const AddressLoaded(addresses: [], selectedAddressId: ''));
        return;
      }

      final userData = userDoc.data() as Map<String, dynamic>;

      List<dynamic> addresses =
          userData.containsKey('addresses') ? userData['addresses'] : [];
      String selectedId = userData.containsKey('selectedAddressId')
          ? userData['selectedAddressId']
          : '';

      // Ensure only one address is marked as primary
      List<Map<String, dynamic>> updatedAddresses = addresses.map((address) {
        return {
          ...address as Map<String, dynamic>,
          'isPrimary':
              address['id'] == selectedId, // Mark selected address as primary
        };
      }).toList();

      emit(AddressLoaded(
        addresses: updatedAddresses,
        selectedAddressId: selectedId,
      ));
    } catch (e) {
      log('Error loading addresses: ${e.toString()}');
      emit(AddressError("Failed to load addresses: ${e.toString()}"));
    }
  }

  // Add Address
  Future<void> _onAddAddress(
      AddAddress event, Emitter<AddressState> emit) async {
    try {
      log('on add user bloc');
      final userId = await userStatus.getUserId();
      DocumentReference userRef = firestore.collection('users').doc(userId);

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot userSnapshot = await transaction.get(userRef);

        final userData = userSnapshot.data() as Map<String, dynamic>? ?? {};

        List<dynamic> addresses =
            userData.containsKey('addresses') ? userData['addresses'] : [];

        if (addresses.length >= 3) {
          throw Exception("You can only save up to 3 addresses.");
        }
        String uniqueId = const Uuid().v4();
        event.newAddress['id'] = uniqueId;
        addresses.add(event.newAddress);

        transaction.set(
            userRef, {'addresses': addresses}, SetOptions(merge: true));
      });

      add(LoadAddresses());
    } catch (e) {
      log(e.toString());
      emit(AddressError("Failed to add address: ${e.toString()}"));
    }
  }

  // Select Address
  Future<void> _onSelectAddress(
      SelectAddress event, Emitter<AddressState> emit) async {
    try {
      final userId = await userStatus.getUserId();
      await firestore.collection('users').doc(userId).set({
        'selectedAddressId': event.addressId,
      }, SetOptions(merge: true));

      add(LoadAddresses());
    } catch (e) {
      log(e.toString());
      emit(AddressError("Failed to select address: ${e.toString()}"));
    }
  }

  // Delete Address
  Future<void> _onDeleteAddress(
      DeleteAddress event, Emitter<AddressState> emit) async {
    try {
      final userId = await userStatus.getUserId();
      DocumentReference userRef = firestore.collection('users').doc(userId);

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot userSnapshot = await transaction.get(userRef);

        final userData = userSnapshot.data() as Map<String, dynamic>? ?? {};
        List<dynamic> addresses =
            userData.containsKey('addresses') ? userData['addresses'] : [];

        if (addresses.isEmpty) {
          throw Exception("No addresses found.");
        }

        addresses.removeWhere((addr) => addr['id'] == event.addressId);
        transaction.update(userRef, {'addresses': addresses});
      });

      add(LoadAddresses());
    } catch (e) {
      emit(AddressError("Failed to delete address: ${e.toString()}"));
    }
  }

  Future<void> _onEditAddress(
      EditAddress event, Emitter<AddressState> emit) async {
    try {
      final userId = await userStatus.getUserId();
      DocumentReference userRef = firestore.collection('users').doc(userId);

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot userSnapshot = await transaction.get(userRef);

        if (!userSnapshot.exists) {
          throw Exception("User not found.");
        }

        List<dynamic> addresses = List.from(userSnapshot['addresses'] ?? []);

        int index =
            addresses.indexWhere((addr) => addr['id'] == event.addressId);
        if (index == -1) {
          throw Exception("Address not found.");
        }

        // Update the address with new details
        addresses[index] = {
          ...addresses[index], // Keep existing data
          'houseName': event.addressModel.houseName,
          'postOffice': event.addressModel.postOffice,
          'district': event.addressModel.district,
          'state': event.addressModel.state,
          'pincode': event.addressModel.pinCode,
        };

        transaction.update(userRef, {'addresses': addresses});
      });

      add(LoadAddresses()); // Reload addresses after edit
    } catch (e) {
      emit(AddressError("Failed to update address: ${e.toString()}"));
    }
  }
}
