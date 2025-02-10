import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.houseName,
    required super.postOffice,
    required super.district,
    required super.state,
    required super.pinCode,
    super.isPrimary,
  });

  // Convert Firestore document to AddressModel
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      houseName: map['houseName'] ?? '',
      postOffice: map['postOffice'] ?? '',
      district: map['district'] ?? '',
      state: map['state'] ?? '',
      pinCode: map['pinCode'] ?? '',
      isPrimary: map['isPrimary'] ?? false,
    );
  }

  // Convert AddressModel to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'houseName': houseName,
      'postOffice': postOffice,
      'district': district,
      'state': state,
      'pinCode': pinCode,
      'isPrimary': isPrimary,
    };
  }
}
