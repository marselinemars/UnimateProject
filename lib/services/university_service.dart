import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../core/constants/endpoints.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_service.dart';

class UniversityService {
  static Dio dio = Dio(); // Initialize Dio instance

  static Future<String> _getUserId() async {
    UserModel? user = await UserAuthentication.getLoggedUser();

    return user!.id;
  }

  static Future<String> submitUniversityData(
      Map<String, dynamic> formData,
      Map<String, File> distinguishedImages,
      List<File> additionalImages) async {
    print('i am called to submit uni ');
    Response response;
    try {
      // Add user ID to formData
      formData['contributor_id'] = await _getUserId();

      // Create FormData
      FormData data = FormData.fromMap({
        ...formData, // formData contains the fields from universityInfoSections
        if (distinguishedImages['main_picture'] != null)
          'main_picture': await MultipartFile.fromFile(
            distinguishedImages['main_picture']!.path,
            filename: distinguishedImages['main_picture']!.path.split('/').last,
          ),
        if (distinguishedImages['logo_picture'] != null)
          'logo_picture': await MultipartFile.fromFile(
            distinguishedImages['logo_picture']!.path,
            filename: distinguishedImages['logo_picture']!.path.split('/').last,
          ),
        'additional_images': [
          for (File image in additionalImages)
            await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last),
        ],
      });

      String apiUrl =
          'http://192.168.43.219:5000/universities/submitUniversityData'; // Replace with your actual API endpoint

      response = await dio.post(
        apiUrl,
        data: data,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return 'University data submitted successfully!';
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!.data['message'] ?? 'Error occurred';
      } else {
        return 'Network error';
      }
    }
  }

  // Add other methods as needed for university operations
}
