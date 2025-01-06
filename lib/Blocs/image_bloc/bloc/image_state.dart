part of 'image_bloc.dart';

class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}

class ImageIndexUpdated extends ImageState {
  final int currentIndex;

  const ImageIndexUpdated(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
