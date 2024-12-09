class RiderModel {
  final int id;
  final String riderUuid;
  final String? fullName;
  final String email;
  final String? phone;
  final String? image;
  final String? otpExpiresAt;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? virtualAccountNumber;
  final String? virtualAccountName;
  final String? lastLoggedIn;
  final bool loggedIn;
  final String walletBalance;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  RiderModel({
    required this.id,
    required this.riderUuid,
    this.fullName,
    required this.email,
    this.phone,
    this.image,
    this.otpExpiresAt,
    this.street,
    this.city,
    this.state,
    this.country,
    this.virtualAccountNumber,
    this.virtualAccountName,
    this.lastLoggedIn,
    required this.loggedIn,
    required this.walletBalance,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory RiderModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RiderModel(
      id: json['id'] ?? 0,
      riderUuid: json['rider_uuid'] ?? "",
      fullName: json['full_name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      image: json['image'] ?? "",
      otpExpiresAt: json['otp_expires_at'] ?? "",
      street: json['street'] ?? "",
      city: json['city'] ?? "",
      state: json['state'] ?? "",
      country: json['country'] ?? "",
      virtualAccountNumber: json['virtual_account_number'] ?? "",
      virtualAccountName: json['virtual_account_name'] ?? "",
      lastLoggedIn: json['last_logged_in'] ?? "",
      loggedIn: json['logged_in'] ?? false,
      walletBalance: json['wallet_balance'] ?? "",
      status: json['status'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rider_uuid': riderUuid,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'image': image,
      'otp_expires_at': otpExpiresAt,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'virtual_account_number': virtualAccountNumber,
      'virtual_account_name': virtualAccountName,
      'last_logged_in': lastLoggedIn,
      'logged_in': loggedIn,
      'wallet_balance': walletBalance,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
