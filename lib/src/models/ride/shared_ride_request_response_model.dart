class SharedRideRequestResponseModel {
  final int status;
  final String message;
  final RideBooking? booking;
  final SharedRideGroup? sharedRideGroup;
  final String riderPhone;

  SharedRideRequestResponseModel({
    required this.status,
    required this.message,
    this.booking,
    this.sharedRideGroup,
    required this.riderPhone,
  });

  factory SharedRideRequestResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    final data = json["data"] as Map<String, dynamic>?;

    return SharedRideRequestResponseModel(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      booking: data?["booking"] != null
          ? RideBooking.fromJson(data!["booking"])
          : null,
      sharedRideGroup: data?["shared_ride_group"] != null
          ? SharedRideGroup.fromJson(data!["shared_ride_group"])
          : null,
      riderPhone: data?["rider_phone"] ?? "",
    );
  }
}

class RideBooking {
  final String riderUUID;
  final String pickupAddress;
  final double pickupLatitude;
  final double pickupLongitude;
  final String destinationAddress;
  final double destinationLatitude;
  final double destinationLongitude;
  final int amount;
  final String type;
  final String paymentType;
  final String status;
  final bool isOngoing;
  final double distance;
  final int estimatedTime;
  final String bookedAt;
  final int sharedRideGroupId;
  final String updatedAt;
  final String createdAt;
  final int id;

  RideBooking({
    required this.riderUUID,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.destinationAddress,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.amount,
    required this.type,
    required this.paymentType,
    required this.status,
    required this.isOngoing,
    required this.distance,
    required this.estimatedTime,
    required this.bookedAt,
    required this.sharedRideGroupId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory RideBooking.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return RideBooking(
      riderUUID: json["riderUUID"] ?? "",
      pickupAddress: json["pickup_address"] ?? "",
      pickupLatitude: (json["pickup_latitude"] as num?)?.toDouble() ?? 0.0,
      pickupLongitude: (json["pickup_longitude"] as num?)?.toDouble() ?? 0.0,
      destinationAddress: json["destination_address"] ?? "",
      destinationLatitude:
          (json["destination_latitude"] as num?)?.toDouble() ?? 0.0,
      destinationLongitude:
          (json["destination_longitude"] as num?)?.toDouble() ?? 0.0,
      amount: json["amount"] ?? 0,
      type: json["type"] ?? "",
      paymentType: json["payment_type"] ?? "",
      status: json["status"] ?? "",
      isOngoing: json["is_ongoing"] ?? false,
      distance: (json["distance"] as num?)?.toDouble() ?? 0.0,
      estimatedTime: json["estimated_time"] ?? 0,
      bookedAt: json["booked_at"] ?? "",
      sharedRideGroupId: json["shared_ride_group_id"] ?? 0,
      updatedAt: json["updated_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      id: json["id"] ?? 0,
    );
  }
}

class SharedRideGroup {
  final String groupUUID;
  final double pickupLatitude;
  final double pickupLongitude;
  final String pickupAddress;
  final double destinationLatitude;
  final double destinationLongitude;
  final String destinationAddress;
  final int maxRiders;
  final int currentRiders;
  final bool isFull;
  final String status;
  final int estimatedFarePerRider;
  final double totalDistance;
  final int estimatedTime;
  final String updatedAt;
  final String createdAt;
  final int id;

  SharedRideGroup({
    required this.groupUUID,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.pickupAddress,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.destinationAddress,
    required this.maxRiders,
    required this.currentRiders,
    required this.isFull,
    required this.status,
    required this.estimatedFarePerRider,
    required this.totalDistance,
    required this.estimatedTime,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory SharedRideGroup.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return SharedRideGroup(
      groupUUID: json["group_uuid"] ?? "",
      pickupLatitude: (json["pickup_latitude"] as num?)?.toDouble() ?? 0.0,
      pickupLongitude: (json["pickup_longitude"] as num?)?.toDouble() ?? 0.0,
      pickupAddress: json["pickup_address"] ?? "",
      destinationLatitude:
          (json["destination_latitude"] as num?)?.toDouble() ?? 0.0,
      destinationLongitude:
          (json["destination_longitude"] as num?)?.toDouble() ?? 0.0,
      destinationAddress: json["destination_address"] ?? "",
      maxRiders: json["max_riders"] ?? 0,
      currentRiders: json["current_riders"] ?? 0,
      isFull: json["is_full"] ?? false,
      status: json["status"] ?? "",
      estimatedFarePerRider: json["estimated_fare_per_rider"] ?? 0,
      totalDistance: (json["total_distance"] as num?)?.toDouble() ?? 0.0,
      estimatedTime: json["estimated_time"] ?? 0,
      updatedAt: json["updated_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      id: json["id"] ?? 0,
    );
  }
}
