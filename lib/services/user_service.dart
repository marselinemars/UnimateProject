import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../controllers/user_controller.dart';
import '../core/constants/endpoints.dart';
import '../main.dart';
import '../models/user_model.dart';

class UserAuthentication {
  static final UserController userController =
      getx.Get.find(); // Get the UserController instance

  static Future<UserModel?> getLoggedUser() async {
    String? id = prefs?.getString("user_id");
    String? email = prefs?.getString("user_email");
    String? name = prefs?.getString("user_name");
    String? avatarUrl = prefs?.getString("user_avatar");
    if (id != null &&
        email != null &&
        name != null &&
        id.isNotEmpty &&
        email.isNotEmpty &&
        name.isNotEmpty) {
      return UserModel(id: id, name: name, email: email, avatarUrl: avatarUrl);
    } else {
      return null;
    }
  }

  static Future<String> loginUser(Map<String, dynamic> data) async {
    Response response;
    try {
      response = await dio.post(apiEndpointUserLogin,
          data: data,
          options: Options(headers: {'Content-Type': 'application/json'}));

      Map retData = jsonDecode(response.toString());
      if (prefs != null) {
        prefs!.setString("user_id", retData['id']);
        prefs!.setString("user_email", retData['email']);
        prefs!.setString("user_name", retData['name']);
        if (retData['avatarUrl'] != null) {
          prefs!.setString('user_avatar', retData['avatarUrl']);
        }

        // Set user's logged-in state using GetX
        userController.setUserLoggedIn(true);
        userController.setUserData(
            id: retData['id'],
            email: retData['email'],
            name: retData['name'],
            avatarUrl: retData['avatarUrl']);
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

  static Future<String> signupUser({
    required Map<String, dynamic> data,
    File? avatarImage,
  }) async {
    Response response;
    FormData formData = FormData.fromMap({
      'name': data['name'],
      'email': data['email'],
      'password': data['password'],
      'confirmPassword': data['confirmPassword'],
      'avatar': avatarImage != null
          ? await MultipartFile.fromFile(avatarImage.path,
              filename: 'avatar_image.jpg')
          : null,
    });
     
    try {
      response = await Dio().post(
        apiEndpointUserSignUp,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      Map<String, dynamic> retData = jsonDecode(response.toString());
      if (prefs != null) {
        prefs!.setString('user_id', retData['id']);
        prefs!.setString('user_email', retData['email']);
        prefs!.setString('user_name', retData['name']);
        if (retData['avatarUrl'] != null) {
          prefs!.setString('user_avatar', retData['avatarUrl']);
        }
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

  static Future<String> logoutUser() async {
    try {
      // Perform logout action here
      // For example, clearing user-related data from preferences
      if (prefs != null) {
        prefs!.remove("user_id");
        prefs!.remove("user_email");
        prefs!.remove("user_name");
        prefs!.remove("user_avatar");
      }

      // You might also need to perform additional actions like clearing tokens, etc.

      return 'success';
    } catch (e) {
      // Handle logout failure or exceptions here
      return 'Error: ${e.toString()}';
    }
  }

  static Future<Map<String, dynamic>> getUserById(userId) async {
    Response response;
    try {
      response = await dio.post(
        apiEndpointGetUserById,
        data: {"userId": userId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response?.data['message'];
        List<String> errors =
            List<String>.from(e.response?.data['errors'] ?? []);
        String combinedErrorMessage = '$errorMessage, ${errors.join(', ')}';
        return {"errors": combinedErrorMessage};
      } else {
        return {"errors": 'Network error'};
      }
    }
  }
}
