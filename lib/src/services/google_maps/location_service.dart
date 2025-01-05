import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/google_maps/autocomplete_prediction_model.dart';
import 'package:green_wheels/src/services/google_maps/places_auto_complete_model.dart';
import 'package:http/http.dart' as http;

class LocationService {
  var googlePlacesApiKey = dotenv.env['GooglePlacesAPIKey'];

  Future<String> getPlaceId(String query) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$query&inputtype=textquery&key=$googlePlacesApiKey";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'] as String;

    log(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String query) async {
    final placeId = await getPlaceId(query);

    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googlePlacesApiKey";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['result'] as Map<String, dynamic>;

    log(results.toString());

    return results;
  }

  static Future<String?> fetchUrl(Uri uri, String baseURL,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

void googlePlaceAutoComplete(
  String query,
  List<GooglePlaceAutoCompletePredictionModel> placePredictions,
) async {
  var googlePlacesApiKey = dotenv.env['GooglePlacesAPIKey'];

  Uri uri = Uri.https(
      "maps.googleapis.com",
      '/maps/api/place/autocomplete/json', // unencoded path
      {
        "input": query, // query params
        "key": googlePlacesApiKey, // google places api key
      });

  String? response = await LocationService.fetchUrl(uri, ApiUrl.baseUrl);

  GooglePlaceAutoCompleteResponseModel result =
      GooglePlaceAutoCompleteResponseModel.parseAutoCompleteResult(
    response ?? "",
  );

  if (result.predictions != null && result.predictions!.isNotEmpty) {
    placePredictions.clear();
    placePredictions.addAll(result.predictions!);
    log("Place predictions: ${placePredictions.map((e) => e.description).toList()}");
  } else {
    log("Place predictions is Empty");
  }
}

Future<List> parseLatLng(String newLocation) async {
  List<Location> location = await locationFromAddress(newLocation);
  String latitude = location[0].latitude.toString();
  String longitude = location[0].longitude.toString();
  return [latitude.toString(), longitude.toString()];
}
