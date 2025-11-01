import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/realtime_data.dart';

class ApiService {
  // TODO: Replace with your Django backend URL
  static const String baseUrl = 'http://localhost:8000';
  
  Future<RealtimeData?> fetchRealtimeData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/realtime/'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RealtimeData.fromJson(jsonData);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  // Mock data for testing without backend
  Future<RealtimeData> fetchMockData() async {
    await Future.delayed(const Duration(seconds: 1));
    
    final mockJson = {
      "sensor_data": {
        "temperature": 28.5,
        "humidity_air": 60,
        "humidity_soil": 35,
        "rain_forecast": 2
      },
      "plants": [
        {
          "name": "Tomate",
          "water_need": "élevé",
          "watering_plan": [
            {"day": "Lundi", "duration_min": 20},
            {"day": "Jeudi", "duration_min": 15}
          ]
        },
        {
          "name": "Laitue",
          "water_need": "moyen",
          "watering_plan": [
            {"day": "Mardi", "duration_min": 10},
            {"day": "Vendredi", "duration_min": 10}
          ]
        },
        {
          "name": "Cactus",
          "water_need": "faible",
          "watering_plan": [
            {"day": "Dimanche", "duration_min": 5}
          ]
        }
      ]
    };

    return RealtimeData.fromJson(mockJson);
  }
}
