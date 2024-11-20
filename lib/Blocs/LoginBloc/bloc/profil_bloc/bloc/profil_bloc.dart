import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  final String cloudName = 'devitg04d';
  final String apiKey = '913442333959589';
  final String apiSecret = 'WwM6KFJa0LJt2n-Yiq6B--7Md8c';
  final String uploadPreset = 'cvkx7sib';
  ProfilBloc() : super(ProfilInitial()) {
    on<UploadImageEvent>(_onUploadImage);
  }

  Future<void> _onUploadImage(
      UploadImageEvent event, Emitter<ProfilState> emit) async {
    emit(CloudinaryLoading());
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    File imageFile = File(pickedFile.path);
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final signature = _generateSignature(timestamp, '1231');

    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path))
      ..fields['api_key'] = apiKey
      ..fields['timestamp'] = timestamp
      ..fields['signature'] = signature
      ..fields['upload_preset'] = uploadPreset
      ..fields['public_id'] = 'user_1231';
    // 'user_$userId';

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    try {
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path))
        ..fields['api_key'] = apiKey
        ..fields['timestamp'] = timestamp
        ..fields['signature'] = signature
        ..fields['upload_preset'] = uploadPreset
        ..fields['public_id'] = 'user_1231';
      // 'user_${event.userId}';

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(responseData);

        print("Upload successful: ${responseJson['secure_url']}");
        log(responseJson.toString());
        return responseJson['secure_url'];
      } else {
        print('Image upload failed: ${response.statusCode}');
        print('Response body: $responseData');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
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

    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final publicId = 'user_${event.userId}';
    final signature = _generateSignatureForDelete(publicId, timestamp);

    try {
      final response = await http.post(
        url,
        body: {
          'public_id': publicId,
          'api_key': apiKey,
          'timestamp': timestamp,
          'signature': signature,
        },
      );

      if (response.statusCode == 200) {
        emit(CloudinaryDeleted());
      } else {
        emit(CloudinaryError('Failed to delete image.'));
      }
    } catch (e) {
      emit(CloudinaryError('Error deleting image: $e'));
    }
  }

  String _generateSignature(String timestamp, String userId) {
    var paramsToSign =
        'public_id=user_$userId&timestamp=$timestamp&upload_preset=$uploadPreset$apiSecret';
    var bytes = utf8.encode(paramsToSign);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  String _generateSignatureForDelete(String publicId, String timestamp) {
    var paramsToSign = 'public_id=$publicId&timestamp=$timestamp$apiSecret';
    var bytes = utf8.encode(paramsToSign);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }
}
