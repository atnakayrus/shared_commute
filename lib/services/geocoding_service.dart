import 'dart:convert';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_commute/models/address.dart';
import 'package:shared_commute/models/google_route.dart';

class GeocodingService {
  final String apiKey = FlutterConfigPlus.get('GOOGLE_MAPS_API_KEY');

  Future<List<Address>> getSuggestions(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(input)}&components=country:in&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        List<Address> suggestions = [];
        for (var suggestion in data['predictions']) {
          final suggested = await GeocodingService()
              .getAddressByName(suggestion['description']);
          suggestions.add(suggested);
        }
        return suggestions;
      } else {
        throw Exception('Error: ${data['status']}');
      }
    } else {
      throw Exception('Failed to connect to Places API');
    }
  }

  Future<Address> getAddressByPlaceId(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'OK') {
          // Return the first result
          return Address.fromJson(data['results'][0]);
        } else {
          throw Exception('Error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to fetch place details');
      }
    } catch (e) {
      throw Exception('Error fetching place details: $e');
    }
  }

  Future<Address> getAddressByName(String address) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        Address address = Address.fromJson(data['results'][0]);
        return address;
      } else {
        throw Exception('Error: ${data['status']}');
      }
    } else {
      throw Exception('Failed to connect to Geocoding API');
    }
  }

  Future<Address> getAddressByLatLng(double latitude, double longitude) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        Address address = Address.fromJson(data['results'][0]);
        return address;
      } else {
        throw Exception('Error: ${data['status']}');
      }
    } else {
      throw Exception('Failed to connect to Geocoding API');
    }
  }

  Future<GoogleRoute> getPathDistance(LatLng origin, LatLng destination) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey&mode=driving'; // Change 'mode' to 'walking', 'bicycling', or 'transit' as needed.

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if ((data['routes'] as List).isNotEmpty) {
        final route = data['routes'][0];
        final leg = route['legs'][0];

        final GoogleRoute gRoute = GoogleRoute.fromJson(leg);
        return gRoute;
      } else {
        throw Exception('No routes found');
      }
    } else {
      throw Exception('Failed to fetch directions');
    }
  }
}
