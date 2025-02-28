// import 'dart:convert';

class RideStartedResponseModel {
  final String event;
  final RideStartedData data;
  final String channel;

  RideStartedResponseModel({
    required this.event,
    required this.data,
    required this.channel,
  });

  factory RideStartedResponseModel.fromJson(Map<String, dynamic> json) {
    return RideStartedResponseModel(
      event: json['event'] ?? '',
      data: RideStartedData.fromJson(json['data'] ?? {}),
      // data: RideStartedData.fromJson(jsonDecode(json['data'] ?? '{}')),
      channel: json['channel'] ?? '',
    );
  }
}

class RideStartedData {
  final int bookingId;
  final String type;
  final String message;
  final BookingInfo bookingInfo;
  final String riderPhone;
  final RideDetails data;

  RideStartedData({
    required this.bookingId,
    required this.type,
    required this.message,
    required this.bookingInfo,
    required this.riderPhone,
    required this.data,
  });

  factory RideStartedData.fromJson(Map<String, dynamic> json) {
    return RideStartedData(
      bookingId: json['booking_id'] ?? 0,
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      bookingInfo: BookingInfo.fromJson(json['booking_info'] ?? {}),
      riderPhone: json['rider_phone'] ?? '',
      data: RideDetails.fromJson(json['data'] ?? {}),
    );
  }
}

class BookingInfo {
  final String bookingType;

  BookingInfo({required this.bookingType});

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      bookingType: json['booking_type'] ?? '',
    );
  }
}

class RideDetails {
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

  RideDetails({
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

  factory RideDetails.fromJson(Map<String, dynamic> json) {
    return RideDetails(
      pickupLocation: Location.fromJson(json['pickup_location'] ?? {}),
      destination: Location.fromJson(json['destination'] ?? {}),
      amount: double.tryParse(json['amount']?.toString() ?? '0.0') ?? 0.0,
      paymentType: json['payment_type'] ?? '',
      estimatedTime: json['estimated_time'] ?? 0,
      distance: double.tryParse(json['distance']?.toString() ?? '0.0') ?? 0.0,
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      type: json['type'] ?? '',
      scheduleType: json['schedule_type'],
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

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'] ?? '',
      lat: double.tryParse(json['lat']?.toString() ?? '0.0') ?? 0.0,
      long: double.tryParse(json['long']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}
