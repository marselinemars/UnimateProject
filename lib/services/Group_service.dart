import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:unimate/services/comman_services.dart';
import '../core/constants/endpoints.dart'; // Replace with the correct path
import '../main.dart';
import 'package:dio/dio.dart';
import '../models/post_model.dart';

class Group {
  static Future<String> Addgroup(
      {required Map<String, dynamic> data, File? avatarImage}) async {
    Response response;
    FormData formData = FormData.fromMap({
      'name': data['name'],
      'bio': data['bio'],
      'specialty': data['specialty'],
      'tags': data['tags'],
      'year': data['year'],
      'adminid': data['adminid'],
      'avatar': avatarImage != null
          ? await MultipartFile.fromFile(avatarImage.path,
              filename: 'avatar_image.jpg')
          : null,
    });

    try {
      response = await Dio().post(
        apiEndpointUseraddGroup,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      Map<String, dynamic> retData =
          Map<String, dynamic>.from(jsonDecode(response.toString()));

      if (prefs != null) {
          
        int currentNum = prefs!.getInt("num_groups") ?? 0;
        currentNum++; 
        int currentNum2 = prefs!.getInt("num_allgroups") ?? 0;
        currentNum2++;// Increment the value

        prefs!.setInt('num_groups', currentNum);
        prefs!.setInt('num_allgroups', currentNum2);

        String? groupsIdString = prefs!.getString("group_ids");

        // Convert the existing groupsId string to a list of strings
        List<String> groupsIdList = [];

        if (groupsIdString != null) {
          // Split the existing string using commas
          groupsIdList = groupsIdString.split(',');

          // Add the new group ID to the list
          groupsIdList.add(retData["groupid"]);

          // Convert the updated list back to a string
          String updatedGroupsIdString = groupsIdList.join(',');

          // Store the updated list back in SharedPreferences
          prefs!.setString('group_ids', updatedGroupsIdString);
        } else {
          // If there was no existing string, just set the new group ID
          prefs!.setString('group_ids', retData['groupid']);
        }
      }

//store the id in the local db

      return retData["groupid"];
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

  static Future<Map<String, Map<String, dynamic>>> getmygroups() async {
    Response response;
    String groups_id = getgroupsid();

    FormData formData = FormData.fromMap({
      'ids': groups_id,
    });
    try {
      response = await Dio().post(
        apiEndpointGetMyGroups,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Successful response
        Map<String, Map<String, dynamic>> groupsData =
            Map<String, Map<String, dynamic>>.from(
                jsonDecode(response.toString()));
        return groupsData;
      } else {
        // Handle error
        return {
          'error': {'error': 'Failed to get groups'}
        };
      }
    } on DioException catch (e) {
      // Handle DioException
      if (e.response != null) {
        String errorMessage = e.response?.data['message'];
        List<String> errors =
            List<String>.from(e.response?.data['errors'] ?? []);
        String combinedErrorMessage = '$errorMessage, ${errors.join(', ')}';
        return {
          'error': {'error': combinedErrorMessage}
        };
      } else {
        return {
          'error': {'error': 'Network error'}
        };
      }
    }
  }
    static Future<Map<String, Map<String, dynamic>>> getSuggestedGroup() async {
    Response response;
    String groups_id = getgroupsid();

    FormData formData = FormData.fromMap({
      'ids': groups_id,
    });
    try {
      
      response = await Dio().post(
        apiEndpointGetMySuggestedGroups,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Successful response
        Map<String, Map<String, dynamic>> groupsData =
            Map<String, Map<String, dynamic>>.from(
                jsonDecode(response.toString()));
        return groupsData;
      } else {
        // Handle error
        return {
          'error': {'error': 'Failed to get groups'}
        };
      }
    } on DioException catch (e) {
      // Handle DioException
      if (e.response != null) {
        String errorMessage = e.response?.data['message'];
        List<String> errors =
            List<String>.from(e.response?.data['errors'] ?? []);
        String combinedErrorMessage = '$errorMessage, ${errors.join(', ')}';
        return {
          'error': {'error': combinedErrorMessage}
        };
      } else {
        return {
          'error': {'error': 'Network error'}
        };
      }
    }
  }
  

  static Future<String> addcoverimage({String? id, File? avatarImage}) async {
    Response response;
    FormData formData = FormData.fromMap({
      'id': id,
      'avatar': avatarImage != null
          ? await MultipartFile.fromFile(avatarImage.path,
              filename: 'avatar_cover_image.jpg')
          : null,
    });
    try {
      response = await Dio().post(
        apiEndpointaddcoverimage,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'succes'; //i can use response[avatar_url]
      } else {
        // Handle error
        return 'error';
      }
    } on DioException catch (e) {
      // Handle DioException
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

  static Future<String> Editgroup(
      {required Map<String, dynamic> data, File? avatarImage}) async {
    Response response;

    FormData formData = FormData.fromMap({
      'name': data['name'],
      'bio': data['bio'],
      'specialty': data['specialty'],
      'tags': data['tags'],
      'year': data['year'],
      'groupid': data['groupid'],
      'avatar': avatarImage != null
          ? await MultipartFile.fromFile(avatarImage.path,
              filename: 'avatar_image.jpg')
          : null,
    });

    try {
      print("ahlaaaaaaaaa");
      print(avatarImage);
      response = await Dio().post(
        apiEndpointUsereditGroup,
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


  static Future<List<PostModel>> getgroupAllPosts(
      {required String? groupid}) async {
    Response response;
   
    FormData formData = FormData.fromMap({
      'id': groupid,
    });

    try {
      response = await Dio().post(apiEndpointgroupposts,
          data: formData,
          options: Options(headers: {'Content-Type': 'application/json'}));

      List<PostModel> posts = (response.data as List)
                .map((post) => PostModel.fromJson(post))
                .toList();
      
      return posts;
    } catch (e) {
     
      return [];
    }
  }
   static Future<bool> joingroup(String id) async {
    
  Dio dio = Dio();
  FormData formData = FormData.fromMap({'id': id});
  
  try {
    Response response = await dio.post(
      apiEndpointjoingroup,
      data: formData,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.data['success'] == true) {
      // Update your preferences
      int currentNum2 = prefs!.getInt("num_allgroups") ?? 0;
      print("----------------------------ho");
      print(currentNum2);
      currentNum2++; // Increment the value
      prefs!.setInt('num_allgroups', currentNum2);
      String? groupsIdString = prefs!.getString("group_ids");
       List<String> groupsIdList = [];

          
          // Split the existing string using commas
          groupsIdList = groupsIdString!.split(',');

          // Add the new group ID to the list
          groupsIdList.add(id);

          // Convert the updated list back to a string
          String updatedGroupsIdString = groupsIdList.join(',');

          // Store the updated list back in SharedPreferences
          prefs!.setString('group_ids', updatedGroupsIdString);


      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
}
