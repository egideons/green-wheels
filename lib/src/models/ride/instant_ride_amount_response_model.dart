class InstantRideAmountResponseModel {
  final int status;
  final String message;
  final InstantRideData data;

  InstantRideAmountResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InstantRideAmountResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return InstantRideAmountResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: InstantRideData.fromJson(json['data'] ?? {}),
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

class InstantRideData {
  final double amount;
  final PriceBreakdown priceBreakdown;
  final String rideType;

  InstantRideData({
    required this.amount,
    required this.priceBreakdown,
    required this.rideType,
  });

  factory InstantRideData.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return InstantRideData(
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : (json['amount'] ?? 0.0) as double,
      priceBreakdown: PriceBreakdown.fromJson(json['price_breakdown'] ?? {}),
      rideType: json['ride_type'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'price_breakdown': priceBreakdown.toJson(),
      'ride_type': rideType,
    };
  }
}

class PriceBreakdown {
  final double basePrice;
  final double distanceInMeters;
  final double pricePerMeter;
  final double distancePrice;
  final String discountPercentage;
  final double finalPrice;

  PriceBreakdown({
    required this.basePrice,
    required this.distanceInMeters,
    required this.pricePerMeter,
    required this.distancePrice,
    required this.discountPercentage,
    required this.finalPrice,
  });

  factory PriceBreakdown.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return PriceBreakdown(
      basePrice: (json['base_price'] is int)
          ? (json['base_price'] as int).toDouble()
          : (json['base_price'] ?? 0.0) as double,
      distanceInMeters: (json['distance_in_meters'] is int)
          ? (json['distance_in_meters'] as int).toDouble()
          : (json['distance_in_meters'] ?? 0.0) as double,
      pricePerMeter: (json['price_per_meter'] is int)
          ? (json['price_per_meter'] as int).toDouble()
          : (json['price_per_meter'] ?? 0.0) as double,
      distancePrice: (json['distance_price'] is int)
          ? (json['distance_price'] as int).toDouble()
          : (json['distance_price'] ?? 0.0) as double,
      discountPercentage: json['discount_percentage'] ?? "",
      finalPrice: (json['final_price'] is int)
          ? (json['final_price'] as int).toDouble()
          : (json['final_price'] ?? 0.0) as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base_price': basePrice,
      'distance_in_meters': distanceInMeters,
      'price_per_meter': pricePerMeter,
      'distance_price': distancePrice,
      'discount_percentage': discountPercentage,
      'final_price': finalPrice,
    };
  }
}
