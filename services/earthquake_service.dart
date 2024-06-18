import 'dart:convert';
import 'package:http/http.dart' as http;

class EarthquakeService {
  static const String _apiUrl = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  Future<Map<String, dynamic>> getQuakes() async {
    try {
      http.Response response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load earthquake data');
      }
    } catch (e) {
      throw Exception('Failed to fetch earthquake data: $e');
    }
  }
}

