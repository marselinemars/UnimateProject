// user_controller.dart
import 'package:get/get.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs;

  var userId = ''.obs;
  var userEmail = ''.obs;
  var userName = ''.obs;
  var userAvatarUrl = ''.obs;

  void setUserLoggedIn(bool loggedIn) {
    isLoggedIn.value = loggedIn;
  }

  void setUserData({String id = '', String email = '', String name = '', String? avatarUrl = ''}) {
    userId.value = id;
    userEmail.value = email;
    userName.value = name;
    userAvatarUrl.value = avatarUrl ?? "";
  }
}
