class DriverArrivedResponseModel {
  final int bookingId;
  final String type;
  final String message;
  final BookingInfo bookingInfo;
  final String riderPhone;
  final RideData data;
  final Driver driver;
  final String arrivalTime;

  DriverArrivedResponseModel({
    required this.bookingId,
    required this.type,
    required this.message,
    required this.bookingInfo,
    required this.riderPhone,
    required this.data,
    required this.driver,
    required this.arrivalTime,
  });

  factory DriverArrivedResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return DriverArrivedResponseModel(
      bookingId: json["booking_id"] ?? 0,
      type: json["type"] ?? "",
      message: json["message"] ?? "",
      bookingInfo: BookingInfo.fromJson(json["booking_info"] ?? {}),
      riderPhone: json["rider_phone"] ?? "",
      data: RideData.fromJson(json["data"] ?? {}),
      driver: Driver.fromJson(json["driver"] ?? {}),
      arrivalTime: json["arrival_time"] ?? "",
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

class Driver {
  final String firstName;
  final String lastName;
  final String phone;
  final double rating;
  final Location location;

  Driver({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.rating,
    required this.location,
  });

  factory Driver.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Driver(
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      phone: json["phone"] ?? "",
      rating: double.tryParse(json["rating"]?.toString() ?? "0.0") ?? 0.0,
      location: Location.fromJson(json["location"] ?? {}),
    );
  }
}
