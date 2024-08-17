import 'dart:convert';
import 'dart:io';

class ImageHelper {
  static Future<String> imageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }

  static Future<File?> base64ToImage(String base64String) async {
    try {
      List<int> decodedBytes = base64Decode(base64String);
      String dir = (await Directory.systemTemp.createTemp()).path;
      File tempFile = File('$dir/temp_image.png');
      await tempFile.writeAsBytes(decodedBytes);
      return tempFile;
    } catch (e) {
      print('Error decoding base64: $e');
      return null;
    }
  }
}
