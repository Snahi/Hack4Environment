import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hack4environment/models/bounding_box.dart';

class _ServerBoundingBox {
  final double xStart;
  final double yStart;
  final double width;
  final double height;

  _ServerBoundingBox({
    this.xStart,
    this.yStart,
    this.width,
    this.height,
  });

  Map<String, dynamic> toJson() => {
        'xStart': xStart,
        'yStart': yStart,
        'width': width,
        'height': height,
      };
}

class _ServerLabel {
  final String name;

  _ServerLabel({
    this.name,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

class PhotoUploader {
  static const String paramImg = 'file';
  static const String paramBoundingBoxes = 'boundingBoxes';
  static const String paramLabels = 'labels';
  static const String apiUrl =
      'http://ec2-18-157-179-222.eu-central-1.compute.amazonaws.com/api/images';

  static Future<bool> upload(String imgPath, List<BoundingBox> boxes) async {
    bool success = false;
    Dio dio = Dio();
    print(boxes);
    FormData formData = FormData.fromMap({
      paramImg: await MultipartFile.fromFile(imgPath),
      paramBoundingBoxes: jsonEncode(_convertBoxes(boxes),
          toEncodable: (e) => (e as _ServerBoundingBox).toJson()),
      paramLabels: jsonEncode(_getLabels(boxes),
          toEncodable: (e) => (e as _ServerLabel).toJson()),
    });
    try {
      var response = await dio.post(apiUrl, data: formData);
      if (response.statusCode == 200) {
        success = true;
      } else {
        print('error in api query, statusCode: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }

    return success;
  }

  static List<_ServerBoundingBox> _convertBoxes(List<BoundingBox> raw) {
    List<_ServerBoundingBox> out = [];
    raw.forEach((element) {
      out.add(_ServerBoundingBox(
        xStart: element.x,
        yStart: element.y,
        width: element.width,
        height: element.height,
      ));
    });

    return out;
  }

  static List<_ServerLabel> _getLabels(List<BoundingBox> boxes) {
    List<_ServerLabel> out = [];
    boxes.forEach((element) {
      out.add(_ServerLabel(name: element.label));
    });

    return out;
  }
}
