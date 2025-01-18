part of 'profil_bloc.dart';

sealed class ProfilState extends Equatable {
  final defaultImage = 'assets/default_profil_image.jpg';

  const ProfilState();

  @override
  List<Object> get props => [];
}

final class ProfilInitial extends ProfilState {}

class CloudinaryLoading extends ProfilState {}

// ignore: must_be_immutable
class CloudinaryUrlRetrieved extends ProfilState {
  String imageUrl = '';
  final bool isNewUpload;

  CloudinaryUrlRetrieved({required this.imageUrl, this.isNewUpload = false});
}

class CloudinaryDeleted extends ProfilState {}

class ShowDefaulImage extends ProfilState {
  final defaultImage = '';
}

class CloudinaryError extends ProfilState {
  final String errorMessage;

  CloudinaryError(this.errorMessage);
}
