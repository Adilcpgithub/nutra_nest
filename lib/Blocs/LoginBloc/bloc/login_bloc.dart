import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    final AuthService authService = AuthService();

    on<SubmitToLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final data = await authService.logInUserWithEmailAndPassword(
            email: event.email, password: event.password);
        if (data.success) {
          emit(LoginSuccess());
          return;
        } else {
          emit(LoginFailed(data.errorMessage ?? 'Login failed'));
          return;
        }
      } catch (e) {
        emit(LoginFailed(e.toString()));
      }
    });
    on<GoogleLogin>((event, emit) async {
      emit(GoogleLoginLoading());
      bool data = false;
      data = await authService.signInWithGoogle();
      if (data) {
        emit(GoogleLoginSuccess());
      } else {
        emit(const GoogleLoginFailed('google auth failed'));
      }
    });
  }
}
