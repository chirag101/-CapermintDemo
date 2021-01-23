class ImageListResponse {
  int status;
  String message;
  List<ImageModel> data;

  ImageListResponse({this.status, this.message, this.data});

  ImageListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<ImageModel>();
      json['data'].forEach((v) {
        data.add(new ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageModel {
  String imageUrl;

  ImageModel({this.imageUrl});

  ImageModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    return data;
  }
}