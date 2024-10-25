part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;

  final bool isPickerVisible;

  const SignUpState(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.password,
      required this.isPickerVisible});

  factory SignUpState.initial() {
    return const SignUpState(
        name: '',
        phoneNumber: '',
        email: '',
        password: '',
        isPickerVisible: false);
  }

  SignUpState copyWith(
      {String? name,
      String? phoneNumber,
      String? email,
      String? password,
      bool? isFormValid,
      bool? isPickerVisible}) {
    return SignUpState(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        password: password ?? this.password,
        isPickerVisible: isPickerVisible ?? this.isPickerVisible);
  }

  @override
  List<Object> get props =>
      [name, phoneNumber, email, password, isPickerVisible];
}
