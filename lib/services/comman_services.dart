

import '../main.dart';


String getCurrentUserId() {
  
  return prefs!.getString("user_id") ?? ''; // Provide a default value if null
}

String getCurrentUsername() {
 
  return prefs!.getString("user_name") ?? ''; 
}
String getCurrentUseravatar() {

  return prefs!.getString("user_avatar") ?? ''; 
}
String getCurrentUserbio() {
  
  return prefs!.getString("bio") ?? ''; 
}
String getCurrentUserEmail() {
  
  return prefs!.getString("user_email") ?? ''; 
}

String getCurrentgroupid() {
  return prefs!.getString("id_group") ?? ''; 
}

String getgroupsid(){
  return prefs!.getString("group_ids")?? '';
}
String isadmin(){
  return prefs!.getString("isAdmin")?? '';
}
int getnumgroups(){
  return prefs!.getInt("num_groups")?? 0;
}
int getnumallgroups(){
  return prefs!.getInt("num_allgroups")?? 0;
}

