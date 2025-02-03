part of 'profil_bloc.dart';

sealed class ProfilState extends Equatable {
  final defaultImage = 'assets/default_profil_image.jpg';

  const ProfilState();

  @override
  List<Object> get props => [];
}

final class ProfilInitial extends ProfilState {}

class ProfileImageLoading extends ProfilState {}

// ignore: must_be_immutable
class ProfilImageSuccessful extends ProfilState {
  String imageUrl = '';
  final bool isNewUpload;

  ProfilImageSuccessful({required this.imageUrl, this.isNewUpload = false});
}

class ProfilImageDeleted extends ProfilState {}

class ShowDefaulImage extends ProfilState {
  @override
  // ignore: overridden_fields
  final String defaultImage = '';

  @override
  List<Object> get props => [defaultImage];
}

class CloudinaryError extends ProfilState {
  final String errorMessage;

  const CloudinaryError(this.errorMessage);
}
