import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ReverbWebSocketService {
  late WebSocketChannel channel;
  final String driverUUID;
  final String authToken;

  ReverbWebSocketService({
    required this.driverUUID,
    required this.authToken,
  });

  void connect() {
    // Create WebSocket connection
    // Replace with your actual host and port
    final wsUrl = Uri.parse('ws://api.essemobility.com/app/cygaoogiqefiuj5gb8t3');
    
    channel = WebSocketChannel.connect(wsUrl);

    // Listen to incoming messages
    channel.stream.listen(
      (dynamic message) {
        final decodedMessage = jsonDecode(message);
        handleWebSocketMessage(decodedMessage);
      },
      onError: (error) {
        print('WebSocket Error: $error');
        // Implement reconnection logic here
      },
      onDone: () {
        print('WebSocket connection closed');
        // Implement reconnection logic here
      },
    );

    // Subscribe to channels after connection
    subscribeToChannels();
  }

  void subscribeToChannels() {
    // Subscribe to driver's private channel
    final driverSubscription = {
      'event': 'pusher:subscribe',
      'data': {
        'channel': 'private-driver.$driverUUID',
        'auth': authToken // You'll need to implement proper auth
      }
    };
    channel.sink.add(jsonEncode(driverSubscription));

    // Subscribe to general booking channel
    final bookingSubscription = {
      'event': 'pusher:subscribe',
      'data': {
        'channel': 'private-booking.new',
        'auth': authToken
      }
    };
    channel.sink.add(jsonEncode(bookingSubscription));
  }

  void handleWebSocketMessage(Map<String, dynamic> message) {
    if (message['event'] == 'booking.update') {
      final data = jsonDecode(message['data']);
      switch (data['type']) {
        case 'new_booking':
          handleNewBooking(data['booking']);
          break;
        case 'booking_accepted':
          handleBookingAccepted(data['booking']);
          break;
        case 'booking_cancelled':
          handleBookingCancelled(data['booking']);
          break;
      }
    }
  }

  void handleNewBooking(Map<String, dynamic> bookingData) {
    // Implement new booking handling logic
    print('New booking received: $bookingData');
  }

  void handleBookingAccepted(Map<String, dynamic> bookingData) {
    // Implement booking accepted logic
    print('Booking accepted: $bookingData');
  }

  void handleBookingCancelled(Map<String, dynamic> bookingData) {
    // Implement booking cancelled logic
    print('Booking cancelled: $bookingData');
  }

  void disconnect() {
    channel.sink.close(status.goingAway);
  }
}

// Usage example:
/*
void main() {
  final webSocketService = ReverbWebSocketService(
    driverUUID: 'your-driver-uuid',
    authToken: 'your-auth-token'
  );
  
  webSocketService.connect();
  
  // Don't forget to disconnect when done
  // webSocketService.disconnect();
}
*/