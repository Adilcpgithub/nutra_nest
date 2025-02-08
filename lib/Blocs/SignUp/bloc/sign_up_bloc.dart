// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    AuthService authService = AuthService();
    on<SubmitToSignUp>((event, emit) async {
      emit(SignUpLoading());
      try {
        final data = await authService.createUserWithEmailAndPassword(
          name: event.name,
          phoneNumber: event.phoneNumber,
          email: event.email,
          password: event.password,
        );

        if (data.success) {
          emit(SignUpSuccess());
          return;
        } else {
          emit(SignUpFailed(data.errorMessage ?? 'SignUp failed'));
          return;
        }
      } catch (e) {
        emit(SignUpFailed(e.toString()));
      }
    });
    on<GoogleSignUp>((event, emit) async {
      emit(GoogleSignUpLoading());
      bool data = false;
      data = await authService.signInWithGoogle();
      if (data) {
        emit(GoogleSignUpSuccess());
        return;
      } else {
        emit(const GoogleSignUpFailed('google auth failed'));
        return;
      }
    });
  }
}
