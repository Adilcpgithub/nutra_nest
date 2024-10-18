import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(const SplashState(imageSize: 100, rotate: 90, opacity: 0.0)) {
    on<StartAnimationEvent>(_onStartAnimation);
  }
  Future<void> _onStartAnimation(
      StartAnimationEvent event, Emitter<SplashState> emit) async {
    emit(const SplashState(imageSize: 200, rotate: 180, opacity: 0.5));

    emit(const SplashState(imageSize: 280, rotate: 270, opacity: 1.0));
  }
}
