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
  static const String paramContent = 'content';
  static const String apiUrl =
      'http://ec2-3-121-223-217.eu-central-1.compute.amazonaws.com/api/images';

  static Future<bool> upload(String imgPath, List<BoundingBox> boxes) async {
    bool success = false;
    Dio dio = Dio();
    String content = '{"boundingBoxes":' +
        jsonEncode(_convertBoxes(boxes),
            toEncodable: (e) => (e as _ServerBoundingBox).toJson()) +
        ',"labels":' +
        jsonEncode(_getLabels(boxes),
            toEncodable: (e) => (e as _ServerLabel).toJson()) +
        '}';
    FormData formData = FormData.fromMap({
      paramImg: await MultipartFile.fromFile(imgPath),
      paramContent: content,
    });
    try {
      var response = await dio.post(apiUrl, data: formData);
      if (response.statusCode == 201) {
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
