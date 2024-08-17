import 'package:dio/dio.dart';
import 'package:unimate/core/constants/endpoints.dart';
import 'package:unimate/main.dart';

import '../models/comment_model.dart';

class CommentService {
  static Future<String> addComment(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap({
      'userId': userController.userId.value,
      'postId': data['postId'],
      'content': data['content'],
    });
    try {
      await Dio().post(
        apiEndpointCommentAdd,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return 'success';
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response?.data['message'];
        return errorMessage;
      } else {
        return 'Network error';
      }
    }
  }

  static Future<List<CommentModel>> getAllComments(String postId) async {
    Response response;
    try {
      response = await Dio().post(apiEndpointCommentGet,
          data: FormData.fromMap({'postId': postId}),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ));
      List<CommentModel> comments = (response.data as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList();
      return comments;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> vote(bool up, bool redo, String commentId) async {
    try {
      await Dio().post(
        apiEndpointCommentVote,
        data: FormData.fromMap({
          "userId": userController.userId.value,
          "commentId": commentId,
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
      return false;
    }
  }
}
