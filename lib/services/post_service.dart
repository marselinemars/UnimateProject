import 'dart:io';

import 'package:dio/dio.dart';
import 'package:unimate/core/constants/endpoints.dart';
import 'package:unimate/main.dart';

import '../models/post_model.dart';

class PostService {
  static Future<String> addPost(
      {required Map<String, dynamic> data, File? postImage, String?groupid }) async {
        print("haniiii");
        print(groupid);
    FormData formData = FormData.fromMap({
      'userId': data['userId'],
      'content': data['content'],
      'universityTag': data['universityTag'],
      'specialtyTag': data['specialtyTag'],
      'yearTag': data['yearTag'],
      'tags': '{${data['tags'].join(',')}}',
      'image': postImage != null
          ? await MultipartFile.fromFile(postImage.path,
              filename: 'post_image.jpg')
          : null,
       'groupid':groupid  
    });
   
    try {
      await Dio().post(
        apiEndpointPostAdd,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
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

  static Future<List<PostModel>> getAllPosts() async {
    Response response;
    try {
      response = await Dio().post(apiEndpointPostGet);
      List<PostModel> posts = (response.data as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
      return posts;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> vote(bool up, bool redo, String postId) async {
    try {
      await Dio().post(
        apiEndpointPostvote,
        data:  FormData.fromMap({
          "userId": userController.userId.value,
          "postId": postId,
          "up": up ? '1' : '0',
          "redo": redo ? '1' : '0'
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
