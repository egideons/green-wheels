class DriverLocationUpdateResponseModel {
  final int bookingId;
  final String type;
  final String message;
  final BookingInfo bookingInfo;
  final String riderPhone;
  final RideData data;
  final DriverLocation driverLocation;
  final double distanceToPickup;
  final bool hasArrived;

  DriverLocationUpdateResponseModel({
    required this.bookingId,
    required this.type,
    required this.message,
    required this.bookingInfo,
    required this.riderPhone,
    required this.data,
    required this.driverLocation,
    required this.distanceToPickup,
    required this.hasArrived,
  });

  factory DriverLocationUpdateResponseModel.fromJson(
      Map<String, dynamic>? json) {
    json ??= {};
    return DriverLocationUpdateResponseModel(
      bookingId: json["booking_id"] ?? 0,
      type: json["type"] ?? "",
      message: json["message"] ?? "",
      bookingInfo: BookingInfo.fromJson(json["booking_info"] ?? {}),
      riderPhone: json["rider_phone"] ?? "",
      data: RideData.fromJson(json["data"] ?? {}),
      driverLocation: DriverLocation.fromJson(json["driver_location"] ?? {}),
      distanceToPickup:
          double.tryParse(json["distance_to_pickup"]?.toString() ?? "0.0") ??
              0.0,
      hasArrived: json["has_arrived"] ?? false,
    );
  }
}

class BookingInfo {
  final String bookingType;

  BookingInfo({required this.bookingType});

  factory BookingInfo.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return BookingInfo(
      bookingType: json["booking_type"] ?? "",
    );
  }
}

class RideData {
  final Location pickupLocation;
  final Location destination;
  final double amount;
  final String paymentType;
  final int estimatedTime;
  final double distance;
  final String status;
  final String createdAt;
  final String type;
  final String? scheduleType;

  RideData({
    required this.pickupLocation,
    required this.destination,
    required this.amount,
    required this.paymentType,
    required this.estimatedTime,
    required this.distance,
    required this.status,
    required this.createdAt,
    required this.type,
    this.scheduleType,
  });

  factory RideData.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RideData(
      pickupLocation: Location.fromJson(json["pickup_location"] ?? {}),
      destination: Location.fromJson(json["destination"] ?? {}),
      amount: double.tryParse(json["amount"]?.toString() ?? "0.0") ?? 0.0,
      paymentType: json["payment_type"] ?? "",
      estimatedTime: json["estimated_time"] ?? 0,
      distance: double.tryParse(json["distance"]?.toString() ?? "0.0") ?? 0.0,
      status: json["status"] ?? "",
      createdAt: json["created_at"] ?? "",
      type: json["type"] ?? "",
      scheduleType: json["schedule_type"],
    );
  }
}

class Location {
  final String address;
  final double lat;
  final double long;

  Location({
    required this.address,
    required this.lat,
    required this.long,
  });

  factory Location.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Location(
      address: json["address"] ?? "",
      lat: double.tryParse(json["lat"]?.toString() ?? "0.0") ?? 0.0,
      long: double.tryParse(json["long"]?.toString() ?? "0.0") ?? 0.0,
    );
  }
}

class DriverLocation {
  final String driverUuid;
  final double lat;
  final double long;
  final double? heading;
  final double? speed;
  final bool isMoving;
  final String lastUpdated;

  DriverLocation({
    required this.driverUuid,
    required this.lat,
    required this.long,
    this.heading,
    this.speed,
    required this.isMoving,
    required this.lastUpdated,
  });

  factory DriverLocation.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return DriverLocation(
      driverUuid: json["driver_uuid"] ?? "",
      lat: double.tryParse(json["lat"]?.toString() ?? "0.0") ?? 0.0,
      long: double.tryParse(json["long"]?.toString() ?? "0.0") ?? 0.0,
      heading: json["heading"] != null
          ? double.tryParse(json["heading"].toString())
          : null,
      speed: json["speed"] != null
          ? double.tryParse(json["speed"].toString())
          : null,
      isMoving: json["is_moving"] ?? false,
      lastUpdated: json["last_updated"] ?? "",
    );
  }
}
