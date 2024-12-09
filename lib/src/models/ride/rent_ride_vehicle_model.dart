class RentRideVehicleModel {
  final String vehicleName,
      vehicleImage,
      vehicleGearType,
      vehicleFuelType,
      model,
      vehiclePlateNumber;

  final int numOfSeats,
      numOfstars,
      numOfReviews,
      capacity,
      maxHorsePower,
      maxSpeed;
  final double rating, acceleration;

  const RentRideVehicleModel({
    required this.vehicleName,
    required this.vehicleImage,
    required this.vehicleGearType,
    required this.vehicleFuelType,
    required this.numOfSeats,
    required this.model,
    required this.vehiclePlateNumber,
    required this.numOfstars,
    required this.numOfReviews,
    required this.maxHorsePower,
    required this.maxSpeed,
    required this.rating,
    required this.acceleration,
    required this.capacity,
  });
}
