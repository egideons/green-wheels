import 'package:green_wheels/src/models/ride/rent_ride_vehicle_model.dart';

class AvailableVehiclesResponseModel {
  final int status;
  final String message;
  final VehicleData data;

  AvailableVehiclesResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AvailableVehiclesResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AvailableVehiclesResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: VehicleData.fromJson(json['data'] ?? {}),
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

class VehicleData {
  final int total;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final List<VehicleModel> vehicles;

  VehicleData({
    required this.total,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.vehicles,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      total: json['total'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      vehicles: (json['vehicles'] as List? ?? [])
          .map<VehicleModel>((vehicle) => VehicleModel.fromJson(vehicle))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'vehicles': vehicles.map((vehicle) => vehicle.toJson()).toList(),
    };
  }
}
