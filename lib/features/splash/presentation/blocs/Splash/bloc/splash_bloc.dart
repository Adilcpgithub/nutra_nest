// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(const SplashState(imageSize: 300, rotate: 00, opacity: 0.0)) {
    on<StartAnimationEvent>(_onStartAnimation);
  }
  Future<void> _onStartAnimation(
      StartAnimationEvent event, Emitter<SplashState> emit) async {
    emit(const SplashState(imageSize: 400, rotate: 00, opacity: 1.0));

    emit(const SplashState(imageSize: 400, rotate: 00, opacity: 1.0));
  }
}
