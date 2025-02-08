part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final bool activateValidation;
  final bool isPickerVisible;

  const SignUpState(
      {this.isPickerVisible = false, this.activateValidation = false});

  SignUpState copyWith(
      {bool? isFormValid = false,
      bool? isPickerVisible = false,
      bool? activateValidation = false}) {
    return SignUpState(
        isPickerVisible: isPickerVisible ?? this.isPickerVisible,
        activateValidation: activateValidation ?? this.activateValidation);
  }

  @override
  List<Object> get props => [isPickerVisible, activateValidation];
}

class SignUpSuccess extends SignUpState {}

class SignUpFailed extends SignUpState {
  final String errorMessage;
  const SignUpFailed(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class SignUpLoading extends SignUpState {}

class GoogleSignUpSuccess extends SignUpState {}

class GoogleSignUpFailed extends SignUpState {
  final String errorMessage;
  const GoogleSignUpFailed(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GoogleSignUpLoading extends SignUpState {}
