class VehicleModel {
  final String uuid;
  final String name;
  final VehicleDetails details;
  final VehicleSpecifications specifications;
  final VehiclePricing pricing;
  final String status;
  final String commissionDate;

  VehicleModel({
    required this.uuid,
    required this.name,
    required this.details,
    required this.specifications,
    required this.pricing,
    required this.status,
    required this.commissionDate,
  });

  factory VehicleModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VehicleModel(
      uuid: json['uuid'] ?? "",
      name: json['name'] ?? "",
      details: VehicleDetails.fromJson(json['details'] ?? {}),
      specifications:
          VehicleSpecifications.fromJson(json['specifications'] ?? {}),
      pricing: VehiclePricing.fromJson(json['pricing'] ?? {}),
      status: json['status'] ?? "",
      commissionDate: json['commission_date'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'details': details.toJson(),
      'specifications': specifications.toJson(),
      'pricing': pricing.toJson(),
      'status': status,
      'commission_date': commissionDate,
    };
  }
}

class VehicleDetails {
  final String model;
  final String number;
  final String plateNumber;
  final String color;

  VehicleDetails({
    required this.model,
    required this.number,
    required this.plateNumber,
    required this.color,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VehicleDetails(
      model: json['model'] ?? "",
      number: json['number'] ?? "",
      plateNumber: json['plate_number'] ?? "",
      color: json['color'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'number': number,
      'plate_number': plateNumber,
      'color': color,
    };
  }
}

class VehicleSpecifications {
  final String fuelType;
  final String gearType;
  final int capacity;
  final AdditionalSpecifications additionalSpecs;

  VehicleSpecifications({
    required this.fuelType,
    required this.gearType,
    required this.capacity,
    required this.additionalSpecs,
  });

  factory VehicleSpecifications.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VehicleSpecifications(
      fuelType: json['fuel_type'] ?? "",
      gearType: json['gear_type'] ?? "",
      capacity: json['capacity'] ?? 0,
      additionalSpecs:
          AdditionalSpecifications.fromJson(json['additional_specs'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fuel_type': fuelType,
      'gear_type': gearType,
      'capacity': capacity,
      'additional_specs': additionalSpecs.toJson(),
    };
  }
}

class AdditionalSpecifications {
  final bool airConditioning;
  final bool wifi;
  final bool wheelchairAccessible;
  final bool entertainmentSystem;
  final String luggageCapacity;
  final bool childSeatCompatible;

  AdditionalSpecifications({
    required this.airConditioning,
    required this.wifi,
    required this.wheelchairAccessible,
    required this.entertainmentSystem,
    required this.luggageCapacity,
    required this.childSeatCompatible,
  });

  factory AdditionalSpecifications.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AdditionalSpecifications(
      airConditioning: json['air_conditioning'] ?? false,
      wifi: json['wifi'] ?? false,
      wheelchairAccessible: json['wheelchair_accessible'] ?? false,
      entertainmentSystem: json['entertainment_system'] ?? false,
      luggageCapacity: json['luggage_capacity'] ?? "",
      childSeatCompatible: json['child_seat_compatible'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'air_conditioning': airConditioning,
      'wifi': wifi,
      'wheelchair_accessible': wheelchairAccessible,
      'entertainment_system': entertainmentSystem,
      'luggage_capacity': luggageCapacity,
      'child_seat_compatible': childSeatCompatible,
    };
  }
}

class VehiclePricing {
  final int pricePerMinute;
  final String currency;

  VehiclePricing({
    required this.pricePerMinute,
    required this.currency,
  });

  factory VehiclePricing.fromJson(Map<String, dynamic> json) {
    return VehiclePricing(
      pricePerMinute: json['price_per_minute'] ?? 0,
      currency: json['currency'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price_per_minute': pricePerMinute,
      'currency': currency,
    };
  }
}
