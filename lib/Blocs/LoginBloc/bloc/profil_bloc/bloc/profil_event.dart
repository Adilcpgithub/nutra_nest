part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends ProfilEvent {
  final String userId;

  const UploadImageEvent(
    this.userId,
  );
  @override
  List<Object> get props => [userId];
}

class DefaultImageEvent extends ProfilEvent {}

class GetImageUrlEvent extends ProfilEvent {}

class DeleteImageEvent extends ProfilEvent {
  final String userId;

  const DeleteImageEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
