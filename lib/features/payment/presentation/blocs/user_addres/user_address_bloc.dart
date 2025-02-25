import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';

part 'user_address_event.dart';
part 'user_address_state.dart';

class UserAddressBloc extends Bloc<UserAddressEvent, UserAddressState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserStatus userStatus = UserStatus();

  UserAddressBloc() : super(UserAddressLoading()) {
    on<LoadUserAddresses>(_onLoadUserAddresses);
  }
  Future<void> _onLoadUserAddresses(
      LoadUserAddresses event, Emitter<UserAddressState> emit) async {
    try {
      log('calling the LoadUserAddress ');
      final userId = await userStatus.getUserId();
      emit(UserAddressLoading());

      final userAddressesSnapshot =
          await firestore.collection('users').doc(userId).get();
      if (!userAddressesSnapshot.exists ||
          userAddressesSnapshot.data() == null) {
        log('userAddressesSnapshot is empty');
        //emit(const AddressLoaded(addresses: [], selectedAddressId: ''));
        return;
      }
      final userData = userAddressesSnapshot.data() as Map<String, dynamic>;
      log('userData length ${userData.length}');
      List<Map<String, dynamic>> addresses =
          List<Map<String, dynamic>>.from(userData['addresses'] ?? []);
      log('addresses length ${addresses.length}');
      // .map((doc) => {
      //       'houseName': doc['houseName'],
      //       'postoffice': doc['postoffice'],
      //       'distric': doc['district'],
      //       'state': doc['state'],
      //       'pinCode': doc['pincode'],
      //       'isDefault': doc['isDefault'] ?? false,
      //       'id': doc.id
      //     })
      // .toList();

      if (addresses.isEmpty) {
        log('address is empty');
        emit(const UserAddressError(message: "No address found."));
        return;
      }

      // If user has only one address, return it
      if (addresses.length == 1) {
        log('address legth is one');
        emit(UserAddressLoaded(selectedAddress: addresses.first));
        return;
      }

      // Check for default address
      Map<String, dynamic>? defaultAddress;
      String? selectedAddressId;
      if (userData['selectedAddressId'] != null) {
        selectedAddressId = userData['selectedAddressId']!;
      }
      if (selectedAddressId != null) {
        for (var address in addresses) {
          if (address['id'] == selectedAddressId) {
            defaultAddress = address;
            break;
          }
        }
        if (defaultAddress != null) {
          emit(UserAddressLoaded(selectedAddress: defaultAddress));
          return;
        }
      }

      // If default address exists, return it

      log('defaultAddress is not null');
      // If no default is set, return the first address
      emit(UserAddressLoaded(selectedAddress: addresses.first));
    } catch (e) {
      log('error occure ${e.toString()}');
      emit(
          UserAddressError(message: "Failed to load address: ${e.toString()}"));
    }
  }
}
