part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class UpdatePhoneNumber extends LoginEvent {
  final String phoneNumber;
  const UpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SubmitToLogin extends LoginEvent {
  final String email;
  final String password;

  const SubmitToLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class GoogleLogin extends LoginEvent {
  @override
  List<Object> get props => [];
}
