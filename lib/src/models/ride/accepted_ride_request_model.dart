class AcceptedRideRequestModel {
  final int bookingId;
  final String type;
  final String message;
  final RideData data;
  final Driver driver;

  AcceptedRideRequestModel({
    required this.bookingId,
    required this.type,
    required this.message,
    required this.data,
    required this.driver,
  });

  factory AcceptedRideRequestModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AcceptedRideRequestModel(
      bookingId: json['booking_id'] ?? 0,
      type: json['type'] ?? "",
      message: json['message'] ?? "",
      data: RideData.fromJson(json['data'] ?? {}),
      driver: Driver.fromJson(json['driver'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'type': type,
      'message': message,
      'data': data.toJson(),
      'driver': driver.toJson(),
    };
  }
}

class RideData {
  final Location pickupLocation;
  final Location destination;
  final String amount;
  final String paymentType;
  final int estimatedTime;
  final String distance;
  final String status;
  final String createdAt;

  RideData({
    required this.pickupLocation,
    required this.destination,
    required this.amount,
    required this.paymentType,
    required this.estimatedTime,
    required this.distance,
    required this.status,
    required this.createdAt,
  });

  factory RideData.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return RideData(
      pickupLocation: Location.fromJson(json['pickup_location'] ?? {}),
      destination: Location.fromJson(json['destination'] ?? {}),
      amount: json['amount'] ?? "",
      paymentType: json['payment_type'] ?? "",
      estimatedTime: json['estimated_time'] ?? 0,
      distance: json['distance'] ?? "",
      status: json['status'] ?? "",
      createdAt: json['created_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickup_location': pickupLocation.toJson(),
      'destination': destination.toJson(),
      'amount': amount,
      'payment_type': paymentType,
      'estimated_time': estimatedTime,
      'distance': distance,
      'status': status,
      'created_at': createdAt,
    };
  }
}

class Location {
  final String address;
  final String lat;
  final String long;

  Location({required this.address, required this.lat, required this.long});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'] ?? "",
      lat: json['lat'] ?? "",
      long: json['long'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'lat': lat,
      'long': long,
    };
  }
}

class Driver {
  final String firstName;
  final String lastName;
  final String phone;
  final double rating;
  final int totalRides;

  Driver({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.rating,
    required this.totalRides,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      phone: json['phone'] ?? "",
      rating: (json['rating'] ?? 0.0 as num).toDouble(),
      totalRides: json['total_rides'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'rating': rating,
      'total_rides': totalRides,
    };
  }
}
