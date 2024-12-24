class ImageUploadResponseModel {
  final int status;
  final String message;
  final ImageData data;

  ImageUploadResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ImageUploadResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ImageUploadResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: ImageData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ImageData {
  final String filename;
  final String path;
  final String updatedAt;
  final String createdAt;
  final int id;

  ImageData({
    required this.filename,
    required this.path,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory ImageData.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return ImageData(
      filename: json['filename'] ?? "",
      path: json['path'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      createdAt: json['created_at'] ?? "",
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'path': path,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
