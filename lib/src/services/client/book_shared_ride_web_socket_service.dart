import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:green_wheels/src/constants/keys.dart';
import 'package:green_wheels/src/controllers/app/home_screen_controller.dart';
import 'package:green_wheels/src/models/ride/accepted_ride_request_model.dart';
import 'package:green_wheels/src/models/ride/driver_arrived_response_model.dart';
import 'package:green_wheels/src/models/ride/driver_location_updates_response_model.dart';
import 'package:green_wheels/src/models/ride/ride_completed_response_model.dart';
import 'package:green_wheels/src/models/ride/ride_started_response_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookSharedRideWebSocketService {
  WebSocketChannel? channel;
  final String riderUUID;
  final String authToken;
  bool? hasNewRequest;
  bool _isManuallyDisconnected = false;

  BookSharedRideWebSocketService({
    required this.riderUUID,
    required this.authToken,
  });

  var webSocketAppKey = Keys.webSocketAppKey;

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

      //! WebSocket is connected - Subscribe to Channels
      subscribeToRideRequestChannel();
      subscribeToDriversLocationUpdateChannel();
      return true;
    } catch (e) {
      log("WebSocket connection error: $e");
      return false;
    }
  }

  void subscribeToRideRequestChannel() {
    // Subscribe to available drivers
    final availableDrivers = {
      "event": "pusher:subscribe",
      "data": {"channel": "rider.$riderUUID.bookings"}
    };
    channel?.sink.add(jsonEncode(availableDrivers));
  }

  void subscribeToDriversLocationUpdateChannel() {
    // Subscribe to drivers location
    final driversLocationUpdate = {
      "event": "pusher:subscribe",
      "data": {"channel": "rider.$riderUUID.location"}
    };
    channel?.sink.add(jsonEncode(driversLocationUpdate));
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
          case 'driver_location_update':
            driverLocationUpdate(data);
            break;
          case 'driver_arrived':
            driverArrived(data);
            break;
          case 'ride_started':
            rideStarted(data);
            break;
          case 'booking_completed':
            rideCompleted(data);
            break;
        }
      }
    } catch (e, stackTrace) {
      log("Error parsing WebSocket message: $e", stackTrace: stackTrace);
    }
  }

  void handleBookingAccepted(Map<String, dynamic> bookingData) {
    // Implement booking accepted logic
    log('$bookingData', name: "Booking Accepted information");

    final acceptedRideRequest = AcceptedRideRequestModel.fromJson(bookingData);

    //! Cache the request response in HomeScreenController
    HomeScreenController.instance.updateRequestResponse(acceptedRideRequest);
  }

  void driverLocationUpdate(Map<String, dynamic> driverLocationData) {
    // Implement driver location updates logic
    log('$driverLocationData', name: "Driver Location Updates information");

    final driverLocationUpdate =
        DriverLocationUpdateResponseModel.fromJson(driverLocationData);

    //! Cache the location data in HomeScreenController
    HomeScreenController.instance
        .updateDriverLocationResponse(driverLocationUpdate);
  }

  void driverArrived(Map<String, dynamic> driverArrivedData) {
    // Implement driver arrived  logic
    log('$driverArrivedData', name: "Driver Arrived information");

    final driverArrivedModel =
        DriverArrivedResponseModel.fromJson(driverArrivedData);

    //! Cache the location data in HomeScreenController
    HomeScreenController.instance
        .updateDriverArrivedResponse(driverArrivedModel);
  }

  void rideStarted(Map<String, dynamic> rideStarted) {
    // Implement ride started logic
    log('$rideStarted', name: "Ride Started information");

    final rideStartedResponse = RideStartedResponseModel.fromJson(rideStarted);

    //! Cache the ride Started in HomeScreenController
    HomeScreenController.instance.rideStartedResponse(rideStartedResponse);
  }

  void rideCompleted(Map<String, dynamic> rideCompleted) {
    // Implement ride completed logic
    log('$rideCompleted', name: "Ride Completed information");

    final rideCompletedResponse =
        RideCompletedResponseModel.fromJson(rideCompleted);

    // //! Cache the ride Completed in HomeScreenController
    HomeScreenController.instance.rideCompletedResponse(rideCompletedResponse);
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
    log("Reconnecting in 500 milliseconds...");
    await Future.delayed(const Duration(milliseconds: 500));
    connect();
  }
}
