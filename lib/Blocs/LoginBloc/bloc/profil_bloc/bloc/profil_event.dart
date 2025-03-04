part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends ProfilEvent {
  const UploadImageEvent();
  @override
  List<Object> get props => [];
}

class DefaultImageEvent extends ProfilEvent {}

class GetImageUrlEvent extends ProfilEvent {}

class DeleteImageEvent extends ProfilEvent {
  final String userId;

  const DeleteImageEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
