class GooglePlaceAutoCompletePredictionModel {
  final String description;

  final StructuredFormattingModel structuredFormatting;

  final String placeId;
  final String reference;

  GooglePlaceAutoCompletePredictionModel({
    required this.description,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
  });

  factory GooglePlaceAutoCompletePredictionModel.fromJson(
      Map<String, dynamic>? json) {
    json ??= {};
    return GooglePlaceAutoCompletePredictionModel(
      description: json['description'] ?? "",
      placeId: json['place_id'] ?? "",
      reference: json['reference'] ?? "",
      structuredFormatting: StructuredFormattingModel.fromJson(
        json['structured_formatting'] ?? {},
      ),
    );
  }
}

class StructuredFormattingModel {
  final String mainText;
  final String secondaryText;

  StructuredFormattingModel({
    required this.mainText,
    required this.secondaryText,
  });

  factory StructuredFormattingModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return StructuredFormattingModel(
      mainText: json['main_text'] ?? "",
      secondaryText: json['secondary_text'] ?? "",
    );
  }
}
