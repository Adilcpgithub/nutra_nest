part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends ProfilEvent {
  final String userId;

  UploadImageEvent(
    this.userId,
  );
}

class DefaultImageEvent extends ProfilEvent {}

class GetImageUrlEvent extends ProfilEvent {}

class DeleteImageEvent extends ProfilEvent {
  final String userId;

  DeleteImageEvent(this.userId);
}
