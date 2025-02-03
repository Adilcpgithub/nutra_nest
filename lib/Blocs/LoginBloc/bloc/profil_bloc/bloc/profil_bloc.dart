import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc() : super(ProfilInitial()) {
    on<UploadImageEvent>(_onUploadImage);
    on<GetImageUrlEvent>(_onGetImageUrl);
  }

  Future<void> _onUploadImage(
      UploadImageEvent event, Emitter<ProfilState> emit) async {
    AuthService authService = AuthService();
    emit(ProfileImageLoading());
    String? imageUrl = await authService.uploadImage();
    if (imageUrl != null) {
      emit(ProfilImageSuccessful(imageUrl: imageUrl, isNewUpload: false));
    }
  }

  Future<void> _onGetImageUrl(
      GetImageUrlEvent event, Emitter<ProfilState> emit) async {
    AuthService authService = AuthService();
    emit(ProfileImageLoading());
    var data = await authService.getUserData(UserStatus.userIdFinal);
    String imageUrl = data?['profileImage'] ?? '';

    if (imageUrl.isNotEmpty) {
      log('you have image $imageUrl');
      emit(ProfilImageSuccessful(imageUrl: imageUrl, isNewUpload: true));
    } else {
      emit(ShowDefaulImage());
    }
  }

  Future<void> onDeleteImage(
      DeleteImageEvent event, Emitter<ProfilState> emit) async {
    emit(ProfileImageLoading());
  }
}
