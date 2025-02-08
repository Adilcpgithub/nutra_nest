part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpSubmitted extends SignUpEvent {}

class ActivateValidation extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class TogglePickerVisibility extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class SubmitToSignUp extends SignUpEvent {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  const SubmitToSignUp(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.password});
  @override
  List<Object> get props => [name, phoneNumber, email, password];
}

class GoogleSignUp extends SignUpEvent {}
