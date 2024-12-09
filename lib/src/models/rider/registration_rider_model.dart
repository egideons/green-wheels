class RegistrationRiderModel {
  final int id;
  final String riderUuid;
  final String fullName;
  final String email;
  final String phone;
  final String image;
  final String otpExpiresAt;
  final String street;
  final String city;
  final String state;
  final String country;
  final String virtualAccountNumber;
  final String virtualAccountName;
  final String lastLoggedIn;
  final bool loggedIn;
  final String walletBalance;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String token;
  final VirtualAccountDetails virtualAccountDetails;

  RegistrationRiderModel({
    required this.id,
    required this.riderUuid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.image,
    required this.otpExpiresAt,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.virtualAccountNumber,
    required this.virtualAccountName,
    required this.lastLoggedIn,
    required this.loggedIn,
    required this.walletBalance,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.token,
    required this.virtualAccountDetails,
  });

  factory RegistrationRiderModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RegistrationRiderModel(
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
      token: json['token'] ?? "",
      virtualAccountDetails:
          VirtualAccountDetails.fromJson(json['virtual_account_details'] ?? {}),
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
      'token': token,
      'virtual_account_details': virtualAccountDetails.toJson(),
    };
  }
}

class VirtualAccountDetails {
  final String accountNumber;
  final String accountName;

  VirtualAccountDetails({
    required this.accountNumber,
    required this.accountName,
  });

  factory VirtualAccountDetails.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VirtualAccountDetails(
      accountNumber: json['account_number'] ?? "",
      accountName: json['account_name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'account_name': accountName,
    };
  }
}
