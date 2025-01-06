part of 'image_bloc.dart';

class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class PageChangedEvent extends ImageEvent {
  final int currentIndex;

  const PageChangedEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
