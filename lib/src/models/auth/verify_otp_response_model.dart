class VerifyOTPResponseModel {
  final int status;
  final String message;
  final Data data;

  VerifyOTPResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyOTPResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VerifyOTPResponseModel(
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
  final String riderId;
  final String token;

  Data({
    required this.riderId,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Data(
      riderId: json['riderId'] ?? "",
      token: json['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver': riderId,
      'token': token,
    };
  }
}
