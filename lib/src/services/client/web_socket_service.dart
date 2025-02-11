import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:green_wheels/src/controllers/app/home_screen_controller.dart';
import 'package:green_wheels/src/models/ride/accepted_ride_request_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ReverbWebSocketService {
  WebSocketChannel? channel;
  final String riderUUID;
  final String authToken;
  bool? hasNewRequest;
  bool _isManuallyDisconnected = false;

  ReverbWebSocketService({
    required this.riderUUID,
    required this.authToken,
  });

  var webSocketAppKey = dotenv.env["WebSocketAppKey"];

  Future<bool> connect() async {
    try {
      _isManuallyDisconnected = false;
      var webSocketAppKey = dotenv.env["WebSocketAppKey"];
      var url = "${ApiUrl.webSocketBaseUrl}/$webSocketAppKey";
      final wsUrl = Uri.parse(url);

      channel = WebSocketChannel.connect(wsUrl);

      // Listen to incoming messages with reconnection logic
      channel!.stream.listen(
        (dynamic message) {
          final decodedMessage = jsonDecode(message);
          handleWebSocketMessage(decodedMessage);
          log("Stream listening decoded message: $decodedMessage");
        },
        onError: (error, stackTrace) {
          log('WebSocket Error: $error', stackTrace: stackTrace);
          log("WebSocket is manually disconnected: $_isManuallyDisconnected");
          if (!_isManuallyDisconnected) {
            reconnect(); // Only reconnect if it was an unintentional disconnect
          }
        },
        onDone: () {
          log('WebSocket connection closed');
          log("WebSocket is manually disconnected: $_isManuallyDisconnected");
          if (_isManuallyDisconnected != true) {
            reconnect(); // Only reconnect if it was an unintentional disconnect
          }
        },
      );

      //! WebSocket is connected - Subscribe to ride channel
      subscribeToRideChannel();
      return true;
    } catch (e) {
      log("WebSocket connection error: $e");
      return false;
    }
  }

  void subscribeToRideChannel() {
    // Subscribe to available drivers
    final availableDrivers = {
      "event": "pusher:subscribe",
      "data": {"channel": "rider.$riderUUID.bookings"}
    };
    channel?.sink.add(jsonEncode(availableDrivers));
  }

  void handleWebSocketMessage(Map<String, dynamic> message) {
    try {
      if (message['event'] == 'booking.event') {
        final data = jsonDecode(message['data']);
        log("Decoded booking event data: $data");

        switch (data['type']) {
          case 'booking_accepted':
            handleBookingAccepted(data);
            break;
        }
      }
    } catch (e, stackTrace) {
      log("Error parsing WebSocket message: $e", stackTrace: stackTrace);
    }
  }

  void handleBookingAccepted(Map<String, dynamic> bookingData) {
    // Implement booking accepted logic
    log('Booking accepted: $bookingData', name: "Booking Accepted information");

    final acceptedRideRequest = AcceptedRideRequestModel.fromJson(bookingData);

    //! Cache the request response in HomeScreenController
    HomeScreenController.instance.updateRequestResponse(acceptedRideRequest);
  }

  void disconnect() {
    _isManuallyDisconnected = true;
    if (channel != null) {
      channel!.sink.close();
      log("WebSocket manually disconnected");
    }
  }

  void reconnect() async {
    if (_isManuallyDisconnected) {
      return;
    } // Skip reconnection if disconnected manually
    log("Reconnecting in 5 seconds...");
    await Future.delayed(const Duration(seconds: 5));
    connect();
  }
}
