import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc() : super(ProfilInitial()) {
    on<UploadImageEvent>(_onUploadImage);
  }

  Future<void> _onUploadImage(
      UploadImageEvent event, Emitter<ProfilState> emit) async {
    AuthService authService = AuthService();
    emit(CloudinaryLoading());
    String? imageUrl = await authService.uploadImage();
    if (imageUrl != null) {
      emit(CloudinaryUploadSuccess(imageUrl));
    }
  }

  Future<void> _onGetImageUrl(
      GetImageUrlEvent event, Emitter<ProfilState> emit) async {
    emit(CloudinaryLoading());

    final url = Uri.parse(
        'https://res.cloudinary.com/devitg04d/image/upload/user_${event.userId}.jpg');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        emit(CloudinaryUrlRetrieved(url.toString()));
      } else {
        emit(CloudinaryError('Failed to retrieve image URL.'));
      }
    } catch (e) {
      emit(CloudinaryError('Error fetching image URL: $e'));
    }
  }

  Future<void> _onDeleteImage(
      DeleteImageEvent event, Emitter<ProfilState> emit) async {
    emit(CloudinaryLoading());
  }
}
