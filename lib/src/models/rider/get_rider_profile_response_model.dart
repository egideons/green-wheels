import 'package:green_wheels/src/models/rider/rider_model.dart';

class GetRiderProfileResponseModel {
  final int status;
  final String message;
  final RiderModel data;

  GetRiderProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetRiderProfileResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return GetRiderProfileResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: RiderModel.fromJson(json['data'] ?? {}),
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
