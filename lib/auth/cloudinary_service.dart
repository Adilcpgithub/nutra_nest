import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryStatus {
  String? errorMessage;
  bool success;
  CloudinaryStatus({this.errorMessage, required this.success});
}

class CloudinaryService {
  final String cloudName = 'devitg04d';
  final String apiKey = '913442333959589';
  final String apiSecret = 'WwM6KFJa0LJt2n-Yiq6B--7Md8c';
  final String uploadPreset = 'cvkx7sib';
  final cloudinary = CloudinaryPublic(
    'devitg04d', // Replace with your cloud name
    'cvkx7sib', // Replace with your upload preset
    cache: false,
  );
  // Method to upload an image to Cloudinary
  Future<String?> uploadImage(String userId) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      File imageFile = File(pickedFile.path);
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          folder: 'profile_images', // Optional: organize images in a folder
          publicId:
              userId, // This will overwrite existing image with same userId
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      log(response.secureUrl);
      return response.secureUrl;

      //   final url =
      //       Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

      //   final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      //   final signature = _generateSignature(timestamp, userId);

      //   var request = http.MultipartRequest('POST', url)
      //     ..files.add(await http.MultipartFile.fromPath('file', imageFile.path))
      //     ..fields['api_key'] = apiKey
      //     ..fields['timestamp'] = timestamp
      //     ..fields['signature'] = signature
      //     ..fields['upload_preset'] = uploadPreset
      //     ..fields['public_id'] = 'user_$userId';

      //   final response = await request.send();
      //   final responseData = await response.stream.bytesToString();

      //   if (response.statusCode == 200) {
      //     final responseJson = jsonDecode(responseData);

      //     print("Upload successful: ${responseJson['secure_url']}");
      //     log(responseJson.toString());
      //     return responseJson['secure_url'];
      //   } else {
      //     print('Image upload failed: ${response.statusCode}');
      //     print('Response body: $responseData');
      //     return null;
      //   }
      // } catch (e) {
      //   print('Error uploading image: $e');
      //   return null;
    } catch (e) {
      print('Error uploading profile image: $e');
      throw Exception('Failed to upload profile image');
    }
  }

  Future<String?> updateImage(String userId) async {
    try {
      // Pick the new image
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      File imageFile = File(pickedFile.path);

      // Upload to Cloudinary
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          folder: 'profile_images',
          publicId: userId, // Ensure this matches the ID of the original image
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      if (response.url.isNotEmpty) {
        log("Image updated successfully: ${response.secureUrl}");
        return response.secureUrl; // New URL with updated version
      } else {
        log("Error updating image: ${response.toString()}");
        return null;
      }
    } catch (e) {
      log("Error updating image: $e");
      throw Exception('Failed to update image');
    }
  }

  // Method to retrieve the image URL from your backend
  // Future<String?> getImageUrl(String userId) async {
  //   // https: //api.example.com/users?user_id=123
  //   log('dd');
  //   final url = Uri.parse(
  //       'https://res.cloudinary.com/devitg04d/image/upload/user_1231.jpg');

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       log('dd');
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);

  //       // Extract the `url` or `secure_url`
  //       final imageUrl = responseData['url'];
  //       print('1;;1');
  //       print(imageUrl);
  //       log('dd');
  //       return url.toString(); // Directly return the URL if accessible
  //     } else {
  //       log('Failed to retrieve image: ${response.statusCode}');
  //       log('Response body: ${response.body}');
  //       return null;
  //     }
  //   } catch (e) {
  //     // Log any exception that occurs during the request
  //     log('Exception occurred while fetching image URL: $e');
  //     return null;
  //   }
  // }

  // Method to delete an image from Cloudinary
  Future<void> deleteImage(String userId) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final publicId =
        'user_$userId'; // Ensure the public_id is in the correct format
    final signature = _generateSignatureForDelete(publicId, timestamp);

    var response = await http.post(
      url,
      body: {
        'public_id':
            publicId, // Ensure this matches the format used during upload
        'api_key': apiKey,
        'timestamp': timestamp,
        'signature': signature,
      },
    );

    if (response.statusCode == 200) {
      print('Image deleted successfully');
    } else {
      print('Failed to delete image: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  String _generateSignatureForDelete(String publicId, String timestamp) {
    var paramsToSign = 'public_id=$publicId&timestamp=$timestamp$apiSecret';
    var bytes = utf8.encode(paramsToSign);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  // Signature generator for upload action
  String _generateSignature(String timestamp, String userId) {
    var paramsToSign =
        'public_id=user_$userId&timestamp=$timestamp&upload_preset=$uploadPreset$apiSecret';
    var bytes = utf8.encode(paramsToSign);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  // Signature generator for delete action
}
