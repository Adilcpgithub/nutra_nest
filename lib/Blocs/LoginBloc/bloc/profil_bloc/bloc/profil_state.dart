part of 'profil_bloc.dart';

sealed class ProfilState extends Equatable {
  final defaultImage = 'assets/default_profil_image.jpg';

  const ProfilState();

  @override
  List<Object> get props => [defaultImage];
}

final class ProfilInitial extends ProfilState {}

class ProfileImageLoading extends ProfilState {}

// ignore: must_be_immutable
class ProfilImageSuccessful extends ProfilState {
  final String imageUrl;
  final bool isNewUpload;

  const ProfilImageSuccessful(
      {required this.imageUrl, this.isNewUpload = false});
  @override
  List<Object> get props => [imageUrl, isNewUpload];
}

class ProfilImageDeleted extends ProfilState {}

class ShowDefaulImage extends ProfilState {
  @override
  // ignore: overridden_fields
  final String defaultImage = '';

  @override
  List<Object> get props => [defaultImage];
}

class ShowMessage extends ProfilState {
  final String message;
  const ShowMessage({required this.message});

  @override
  List<Object> get props => [message];
}
