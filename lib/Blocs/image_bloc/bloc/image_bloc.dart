import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<PageChangedEvent>((event, emit) {
      emit(ImageIndexUpdated(event.currentIndex));
    });
  }
}
