import 'dart:convert';

class RideCompletedResponseModel {
  final String event;
  final RideCompletedData data;
  final String channel;

  RideCompletedResponseModel({
    required this.event,
    required this.data,
    required this.channel,
  });

  factory RideCompletedResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RideCompletedResponseModel(
      event: json["event"] ?? "",
      data: RideCompletedData.fromJson(
        json["data"] ?? {},
      ),
      // data: RideCompletedData.fromJson(
      //   json["data"] != null ? _decodeData(json["data"]) : {},
      // ),
      channel: json["channel"] ?? "",
    );
  }

  static Map<String, dynamic> _decodeData(String data) {
    try {
      return data.isNotEmpty ? jsonDecode(data) : {};
    } catch (e) {
      return {};
    }
  }
}

class RideCompletedData {
  final int bookingId;
  final String type;
  final String message;
  final BookingInfo bookingInfo;
  final String riderPhone;
  final RideData data;

  RideCompletedData({
    required this.bookingId,
    required this.type,
    required this.message,
    required this.bookingInfo,
    required this.riderPhone,
    required this.data,
  });

  factory RideCompletedData.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RideCompletedData(
      bookingId: json["booking_id"] ?? 0,
      type: json["type"] ?? "",
      message: json["message"] ?? "",
      bookingInfo: BookingInfo.fromJson(json["booking_info"] ?? {}),
      riderPhone: json["rider_phone"] ?? "",
      data: RideData.fromJson(json["data"] ?? {}),
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
