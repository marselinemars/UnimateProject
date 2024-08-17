import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../core/constants/endpoints.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_service.dart';

class ResourceService {
  static Dio dio = Dio(); // Initialize Dio instance

  static Future<String> _getUserId() async {
    UserModel? user = await UserAuthentication.getLoggedUser();

    return user!.id;
  }

  static Future<Map<String, String>> fetchResourceCollections() async {
    try {
      String userId = await _getUserId();

      String url =
          '$apiEndpointFetchUserCollections?userId=$userId';
      var response = await dio.get(url);
      Map<String, String> collections = {};
      if (response.statusCode == 200) {
        for (var collection in response.data) {
          String id = collection['id'].toString();
          String name = collection['name'];
          collections[id] = name;
        }
      }
      return collections;
    } catch (e) {
      print('Error fetching resource collections: $e');
      throw Exception('Failed to fetch resource collections');
    }
  }

  static Future<void> sendSelectedCollectionIdsToBackend(
      Set<String> selectedCollectionIds, int resourceId) async {
    print('i am sending the selected collections ');
    try {
      String userId = await _getUserId();
      // Replace with your actual endpoint, include the user ID in the request
      String url =
          apiEndpointSubmitSelectedCollections;
      var response = await dio.post(url, data: {
        'userId': userId,
        'resourceId': resourceId,
        'selectedIds': selectedCollectionIds.toList(),
      });

      print('i returned ');
      if (response.statusCode != 200) {
        throw Exception('Failed to submit collection IDs');
      }
    } catch (e) {
      print('Error sending collection IDs: $e');
      throw Exception('Failed to send collection IDs');
    }
  }

  static Future<void> AddNewCollectionToBackend(String collectionName) async {
    try {
      String userId = await _getUserId();
      // Replace with your actual endpoint, include the user ID in the request
      String url = 'https://uni-mate-api-unimates-projects.vercel.app/resources/addNewCollection';
      var response = await dio.post(url, data: {
        'userId': userId,
        'name': collectionName,
      });
      if (response.statusCode != 200) {
        throw Exception('Failed to add new collection');
      }
    } catch (e) {
      print('Error adding new collection: $e');
      throw Exception('Failed to add new collection');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchCollections(
      String collectionType) async {
    try {
      // Replace with your actual API endpoint for fetching collections
      String apiUrl = 'https://uni-mate-api-unimates-projects.vercel.app/collections/$collectionType';

      Response response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> collectionData = response.data;
        return List<Map<String, dynamic>>.from(
            collectionData.map((item) => item as Map<String, dynamic>));
      } else {
        throw Exception(
            'Failed to fetch collections, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching collections: $e');
      throw Exception('Failed to fetch collections');
    }
  }

  static Future<void> submitRating(int resourceId, double rating) async {
    try {
      // Replace the URL with your actual API endpoint
      String apiUrl = 'https://uni-mate-api-unimates-projects.vercel.app/resources/rateResource';

      // Get the user ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('user_id')!;

      // Replace this with the actual payload structure needed by your server
      Map<String, dynamic> data = {
        'resourceId': resourceId,
        'rating': rating,
        'userId': userId,
      };
      FormData formData = FormData.fromMap(data);

      print(data);

      // Send the rating to the server
      await dio.post(apiUrl, data: formData);
    } catch (e) {
      print('Error submitting rating: $e');
      throw Exception('Failed to submit rating');
    }
  }

  static Future<List<Map<String, String>>> fetchResourcesData() async {
    try {
      Response response = await dio.get(
        'https://uni-mate-api-unimates-projects.vercel.app/resources/getResources',
      );

      if (response.statusCode == 200) {
        print('Returned and status code is 200');
        List<dynamic> data = response.data;
        print('Returned data:');

        List<Map<String, String>> resourcesData = [];

        for (var resource in data) {
          print('Processing resource');

          resourcesData.add({
            'id': resource['id'].toString(),
            'title': resource['title'] ?? '',
            'description': resource['description'] ?? '',
            'specialty': resource['specialty'] ?? '',
            'rating': resource['rating'].toString(),
          });
        }
        print('the error is not here');
        print(resourcesData);

        return resourcesData;
      } else {
        print(
            'Failed to load resources data, status code: ${response.statusCode}');
        throw Exception('Failed to load resources data');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load resources data');
    }
  }

  static Future<Map<String, dynamic>> fetchResourceData(int resourceId) async {
    try {
      Response response = await dio.get(
        'https://uni-mate-api-unimates-projects.vercel.app/resources/$resourceId', // Replace with your actual backend API endpoint
      );

      Map<String, dynamic> retData = jsonDecode(response.toString());
      print(retData);
      print('Raw response: ${response.data}');

      if (true) {
        print('i am here status code 200');
        String title = retData['title'];
        String description = retData['description'];
        List<dynamic> dynamicAttachments = retData['attachments'];
        List<Map<String, String>> attachments =
            dynamicAttachments.map((dynamic item) {
          Map<String, dynamic> mapItem = item as Map<String, dynamic>;
          String fileName = mapItem['fileName'] as String;
          String url = mapItem['url'] as String;

          return {'fileName': fileName, 'url': url};
        }).toList();

        print('Type of attachments: ${attachments.runtimeType}');

        return {
          'title': title,
          'description': description,
          'attachments': attachments,
        };
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load resource data');
    }
  }

  static Future<String> uploadResource(
      Map<String, dynamic> data, Iterable<File> resourceFiles) async {
    Response response;
    print('i am starting the login ');
    try {
      List<MultipartFile> fileParts = [];

      for (File resourceFile in resourceFiles) {
        fileParts.add(await MultipartFile.fromFile(resourceFile.path));
      }

      FormData formData = FormData.fromMap({
        'title': data['title'],
        'specialty': data['specialty'],
        'description': data['description'],
        'user_id': data['user_id'],
        'files': fileParts,
      });

      print('data to be sent : ${data}');
      response = await dio.post(
        apiEndpointResourcesUpload,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      Map retData = jsonDecode(response.toString());
      print('i am returned from test ${retData}');

      print(retData);
      return 'Resource added successfully!';
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data['message'];
        List<String> errors =
            List<String>.from(e.response!.data['errors'] ?? []);
        String combinedErrorMessage = '$errorMessage, ${errors.join(', ')}';
        return combinedErrorMessage;
      } else {
        return 'Network error';
      }
    }
  }
}
