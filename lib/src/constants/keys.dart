import 'package:flutter_dotenv/flutter_dotenv.dart';

class Keys {
  static String? paystackPublicKey = dotenv.env["PayStackLivePublicKey"] ?? "";
  static String? paystackSecretKey = dotenv.env["PayStackLiveSecretKey"] ?? "";

  static String? paystackTestPublicKey =
      dotenv.env["PayStackTestPublicKey"] ?? "";
  static String? paystackTestSecretKey =
      dotenv.env["PayStackTestSecretKey"] ?? "";

  static String? webSocketAppKey = dotenv.env["WebSocketAppKey"] ?? "";

  static String? googleMapsApiKey = dotenv.env["GoogleMapsAPIKey"] ?? "";
  static String? googlePlacesApiKey = dotenv.env["GooglePlacesAPIKey"] ?? "";
}
