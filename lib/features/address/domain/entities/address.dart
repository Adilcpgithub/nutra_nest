import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String id;
  final String houseName;
  final String postOffice;
  final String district;
  final String state;
  final String pinCode;
  final bool isPrimary;

  const Address({
    required this.id,
    required this.houseName,
    required this.postOffice,
    required this.district,
    required this.state,
    required this.pinCode,
    this.isPrimary = false,
  });

  @override
  List<Object?> get props =>
      [id, houseName, postOffice, district, state, pinCode, isPrimary];
}
