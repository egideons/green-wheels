import 'dart:convert';

import 'package:green_wheels/src/services/google_maps/autocomplete_prediction_model.dart';

class GooglePlaceAutoCompleteResponseModel {
  final String status;
  final List<GooglePlaceAutoCompletePredictionModel>? predictions;

  GooglePlaceAutoCompleteResponseModel({
    required this.status,
    this.predictions,
  });

  factory GooglePlaceAutoCompleteResponseModel.fromJson(
      Map<String, dynamic>? json) {
    json ??= {};

    return GooglePlaceAutoCompleteResponseModel(
      status: json['status'] ?? "",
      predictions: json['predictions']
          ?.map<GooglePlaceAutoCompletePredictionModel>(
              (json) => GooglePlaceAutoCompletePredictionModel.fromJson(json))
          .toList(),
    );
  }

  static GooglePlaceAutoCompleteResponseModel parseAutoCompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();

    return GooglePlaceAutoCompleteResponseModel.fromJson(parsed);
  }
}
