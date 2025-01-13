class WalletFundResponseModel {
  final int status;
  final String message;
  final WalletFundData data;

  WalletFundResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WalletFundResponseModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return WalletFundResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: WalletFundData.fromJson(json['data'] ?? {}),
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

class WalletFundData {
  final Transaction transaction;
  final WalletTransaction walletTransaction;
  final int newBalance;
  final String transactionTime;

  WalletFundData({
    required this.transaction,
    required this.walletTransaction,
    required this.newBalance,
    required this.transactionTime,
  });

  factory WalletFundData.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return WalletFundData(
      transaction: Transaction.fromJson(json['transaction'] ?? {}),
      walletTransaction:
          WalletTransaction.fromJson(json['wallet_transaction'] ?? {}),
      newBalance: json['new_balance'] ?? 0,
      transactionTime: json['transaction_time'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction': transaction.toJson(),
      'wallet_transaction': walletTransaction.toJson(),
      'new_balance': newBalance,
      'transaction_time': transactionTime,
    };
  }
}

class Transaction {
  final String reference;
  final String riderUuid;
  final int amount;
  final String status;
  final String channel;
  final String currency;
  final String updatedAt;
  final String createdAt;
  final int id;

  Transaction({
    required this.reference,
    required this.riderUuid,
    required this.amount,
    required this.status,
    required this.channel,
    required this.currency,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Transaction.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return Transaction(
      reference: json['reference'] ?? "",
      riderUuid: json['rider_uuid'] ?? "",
      amount: json['amount'] ?? 0,
      status: json['status'] ?? "",
      channel: json['channel'] ?? "",
      currency: json['currency'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      createdAt: json['created_at'] ?? "",
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'rider_uuid': riderUuid,
      'amount': amount,
      'status': status,
      'channel': channel,
      'currency': currency,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}

class WalletTransaction {
  final String riderUuid;
  final String amount;
  final String type;
  final String description;
  final String reference;
  final String transactionReference;
  final int transactionId;
  final String updatedAt;
  final String createdAt;
  final int id;

  WalletTransaction({
    required this.riderUuid,
    required this.amount,
    required this.type,
    required this.description,
    required this.reference,
    required this.transactionReference,
    required this.transactionId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return WalletTransaction(
      riderUuid: json['rider_uuid'] ?? "",
      amount: json['amount'] ?? "",
      type: json['type'] ?? "",
      description: json['description'] ?? "",
      reference: json['reference'] ?? "",
      transactionReference: json['transaction_reference'] ?? "",
      transactionId: json['transaction_id'] ?? 0,
      updatedAt: json['updated_at'] ?? "",
      createdAt: json['created_at'] ?? "",
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rider_uuid': riderUuid,
      'amount': amount,
      'type': type,
      'description': description,
      'reference': reference,
      'transaction_reference': transactionReference,
      'transaction_id': transactionId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
