import 'package:chirag_patel_23_jan_2021/data/model/image_list_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class ImageRepository {
  Future<List<ImageModel>> getImages(int size);
}

class ImageRepositoryImpl implements ImageRepository {

  @override
  Future<List<ImageModel>> getImages(int size) async {
    var response = await http.get("http://staging-server.in/android-task/api.php?size="+size.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ImageModel> images = ImageListResponse.fromJson(data).data;
      return images;
    } else {
      throw Exception();
    }
  }
}