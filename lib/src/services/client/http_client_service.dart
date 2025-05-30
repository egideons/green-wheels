import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

String header = "application/json";
const content = "application/x-www-form-urlencoded";

class HttpClientService {
  static Future<http.Response?> getRequest([
    String? url,
    String? token,
    Map<String, String>? headers,
  ]) async {
    http.Response? response;

    // log("This is the http client service url: $url");

    try {
      response = await http.get(
        Uri.parse(url!),
        headers: headers ??
            {
              HttpHeaders.contentTypeHeader: header,
              HttpHeaders.authorizationHeader: "Bearer $token",
            },
      );
      // log("This is the http client service response body: ${response.statusCode}");
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      response = null;
      log(e.toString());
    }
    return response;
  }

  static Future<http.Response?> postRequest([
    String? url,
    String? token,
    dynamic data,
    Map<String, String>? headers,
    bool isEncoded = true,
  ]) async {
    http.Response? response;
    try {
      final encodedBody = isEncoded ? jsonEncode(data) : data;
      if (token == null || token.isEmpty) {
        response = await http
            .post(
              Uri.parse(url!),
              headers: headers ??
                  {
                    HttpHeaders.contentTypeHeader: header,
                    "Content-Type": content,
                  },
              body: data,
            )
            .timeout(const Duration(seconds: 20));
      } else {
        response = await http
            .post(
              Uri.parse(url!),
              headers: headers ??
                  {
                    HttpHeaders.contentTypeHeader: header,
                    "Content-Type": content,
                    HttpHeaders.authorizationHeader: "Bearer $token",
                  },
              body: encodedBody,
            )
            .timeout(const Duration(seconds: 20));

        // log(response.body);
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      response = null;
      log(e.toString());
    }
    return response;
  }

  static Future<http.Response?> putRequest([
    String? url,
    String? token,
    dynamic data,
    Map<String, String>? headers,
  ]) async {
    http.Response? response;
    try {
      log("This is the http client service data: $data");

      response = await http
          .put(
            Uri.parse(url!),
            headers: headers ??
                {
                  HttpHeaders.contentTypeHeader: header,
                  "Content-Type": content,
                  HttpHeaders.authorizationHeader: "Bearer $token",
                },
            body: data,
          )
          .timeout(const Duration(seconds: 20));
      log("This is the http client service response body: ${response.body}");
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      response = null;
      log(e.toString());
    }
    return response;
  }

  static Future<http.Response?> patchRequest([
    String? url,
    String? token,
    dynamic data,
    Map<String, String>? headers,
  ]) async {
    http.Response? response;
    try {
      // log("This is the http client service data: $data");

      response = await http
          .patch(
            Uri.parse(url!),
            headers: headers ??
                {
                  HttpHeaders.contentTypeHeader: header,
                  "Content-Type": content,
                  HttpHeaders.authorizationHeader: "Bearer $token",
                },
            body: data,
          )
          .timeout(const Duration(seconds: 20));
      // log("This is the http client service response body: ${response.body}");
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      response = null;
      log(e.toString());
    }
    return response;
  }

  static Future<http.StreamedResponse?> uploadProfilePicture(
    String url,
    String token,
    XFile file,
  ) async {
    http.StreamedResponse? response;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "multipart/form-data",
      });

      // Add the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'file', // field name for the file
        file.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      log("Uploading profile image: ${file.path}");

      response = await request.send().timeout(const Duration(seconds: 20));

      log("Response status code: ${response.statusCode}");
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      // response = null;
      log("Error uploading profile image: $e");
    }
    return response;
  }
}
