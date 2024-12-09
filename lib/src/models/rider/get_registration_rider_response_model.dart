import 'registration_rider_model.dart';

class GetRegistrationRiderResponseModel {
  final int status;
  final String message;
  final RegistrationRiderModel data;

  GetRegistrationRiderResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetRegistrationRiderResponseModel.fromJson(
      Map<String, dynamic>? json) {
    json ??= {};
    return GetRegistrationRiderResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: RegistrationRiderModel.fromJson(json['data']),
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
