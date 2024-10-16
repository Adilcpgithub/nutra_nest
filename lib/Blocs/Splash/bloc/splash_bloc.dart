import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState(imageSize: 100)) {
    on<StartAnimationEvent>(_onStartAnimation);
  }
  Future<void> _onStartAnimation(
      StartAnimationEvent event, Emitter<SplashState> emit) async {
    // await Future.delayed(const Duration(seconds: 1));
    emit(const SplashState(imageSize: 200));
    // await Future.delayed(const Duration(seconds: 1));
    emit(const SplashState(imageSize: 280));
  }
}
