// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(const SplashState(imageSize: 00, rotate: 00, opacity: 0.0)) {
    on<StartAnimationEvent>(_onStartAnimation);
  }
  Future<void> _onStartAnimation(
      StartAnimationEvent event, Emitter<SplashState> emit) async {
    emit(const SplashState(imageSize: 180, rotate: 00, opacity: 0.0));

    emit(const SplashState(imageSize: 280, rotate: 0, opacity: 1.0));
  }
}
