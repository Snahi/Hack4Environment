import 'package:dio/dio.dart';
import 'package:hack4environment/models/bounding_box.dart';

class PhotoUploader {
  static const String paramImg = 'file';
  static const String apiUrl = '';

  static Future<bool> upload(String imgPath, List<BoundingBox> boxes) async {
    print(boxes);
    return true;
    // TODO implement
    // bool success = false;
    // Dio dio = Dio();
    // FormData formData = FormData.fromMap({
    //   paramImg: await MultipartFile.fromFile(imgPath),
    // });
    // try {
    //   var response = await dio.post(apiUrl, data: formData);
    //   if (response.statusCode == 200) {
    //     success = true;
    //   } else {
    //     print('error in api query, statusCode: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print(e);
    // }
    //
    // return success;
  }
}
