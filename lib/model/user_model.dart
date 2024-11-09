class UserModel {
  final String? id;
  final String name;
  final String phoneNumber;
  final String email;
  final String? imageUrl;

  UserModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
    );
  }
}
