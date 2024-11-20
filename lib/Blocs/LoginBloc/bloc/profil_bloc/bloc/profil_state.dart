part of 'profil_bloc.dart';

sealed class ProfilState extends Equatable {
  const ProfilState();

  @override
  List<Object> get props => [];
}

final class ProfilInitial extends ProfilState {}

class CloudinaryLoading extends ProfilState {}

class CloudinaryUploadSuccess extends ProfilState {
  final String? imageUrl;

  CloudinaryUploadSuccess(this.imageUrl);
}

class CloudinaryUrlRetrieved extends ProfilState {
  String imageUrl =
      'https://api.cloudinary.com/v1_1/devitg04d/image/upload/user_1231';

  CloudinaryUrlRetrieved(this.imageUrl);
}

class CloudinaryDeleted extends ProfilState {}

class ShowDefaulImage extends ProfilState {
  final DefaultImage = 'assets/image copy 15.png';
}

class CloudinaryError extends ProfilState {
  final String errorMessage;

  CloudinaryError(this.errorMessage);
}
