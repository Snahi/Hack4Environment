import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hack4environment/models/bounding_box.dart';

class ServerBoundingBox {
  final double xStart;
  final double yStart;
  final double width;
  final double height;

  ServerBoundingBox({
    this.xStart,
    this.yStart,
    this.width,
    this.height,
  });
}

class _ServerLabel {
  final String name;

  _ServerLabel({
    this.name,
  });
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
    FormData formData = FormData.fromMap({
      paramImg: await MultipartFile.fromFile(imgPath),
      paramBoundingBoxes: jsonEncode(_convertBoxes(boxes)),
      paramLabels: jsonEncode(_getLabels(boxes)),
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

  static List<ServerBoundingBox> _convertBoxes(List<BoundingBox> raw) {
    List<ServerBoundingBox> out = [];
    raw.forEach((element) {
      out.add(ServerBoundingBox(
        xStart: element.x,
        yStart: element.y,
        width: element.width,
        height: element.height,
      ));
    });

    return out;
  }

  static List<_ServerLabel> _getLabels(List<BoundingBox> boxes) {
    List<_ServerLabel> out;
    boxes.forEach((element) {
      out.add(_ServerLabel(name: element.label));
    });

    return out;
  }
}
