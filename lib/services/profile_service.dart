import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../core/constants/endpoints.dart'; // Replace with the correct path
import '../main.dart';
import '../models/post_model.dart';
// Replace with the correct path

class Profile {
  static Future<String> editprofile({
    required Map<String, dynamic> data,
    File? avatarImage,
  }) async {
    Response response;
    FormData formData = FormData.fromMap({
      'name': data['name'],
      'bio': data['bio'],
      'userid': data['userid'],
      'avatar': avatarImage != null
          ? await MultipartFile.fromFile(avatarImage.path,
              filename: 'avatar_image.jpg')
          : null,
    });

    try {
      response = await Dio().post(
        apiEndpointUsereditProfile,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      Map retData = jsonDecode(response.toString());
      if (prefs != null) {
        prefs!.setString("user_name", retData['name']);
        if (retData['avatarUrl'] != '') {
          prefs!.setString('user_avatar', retData['avatarUrl']);
        }
        prefs!.setString('bio', retData['bio']);
      }
      return 'success';
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response?.data['message'];
        List<String> errors =
            List<String>.from(e.response?.data['errors'] ?? []);
        String combinedErrorMessage = '$errorMessage, ${errors.join(', ')}';
        return combinedErrorMessage;
      } else {
        return 'Network error';
      }
    }
  }

  static Future<List<PostModel>> getUserAllPosts(
      {required String userid}) async {
    Response response;

    FormData formData = FormData.fromMap({
      'id': userid,
    });

    try {
      response = await Dio().post(apiEndpointUserposttProfile,
          data: formData,
          options: Options(headers: {'Content-Type': 'application/json'}));
          print(response);
      List<PostModel> posts = (response.data as List)
                .map((post) => PostModel.fromJson(post))
                .toList();
      print("---------------------posts");
      return posts;
    } catch (e) {
      print('--------------$e');
      return [];
    }
  }
}
