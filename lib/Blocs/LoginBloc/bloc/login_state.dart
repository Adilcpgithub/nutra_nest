part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isEmailVisible;
  final bool isPickerVisible;
  final String phoneNumber;

  const LoginState({
    this.isEmailVisible = false,
    this.isPickerVisible = false,
    this.phoneNumber = '',
  });
  LoginState copyWith({
    bool? isEmailVisible,
    bool? isPickerVisible,
    String? phoneNumber,
  }) {
    return LoginState(
      isEmailVisible: isEmailVisible ?? this.isEmailVisible,
      isPickerVisible: isPickerVisible ?? this.isPickerVisible,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [isEmailVisible, isPickerVisible, phoneNumber];
}
