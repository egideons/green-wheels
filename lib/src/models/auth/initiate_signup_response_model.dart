class InitiateSignupResponseModel {
  final int status;
  final String message;
  final Data data;

  InitiateSignupResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InitiateSignupResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return InitiateSignupResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: Data.fromJson(json['data'] ?? {}),
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

class Data {
  final int riderId;

  Data({
    required this.riderId,
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return Data(
      riderId: json['rider_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rider_id': riderId,
    };
  }
}
