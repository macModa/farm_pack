import 'package:flutter/material.dart';
import '../models/sensor_data.dart';

class SensorsPage extends StatelessWidget {
  final SensorData sensorData;

  const SensorsPage({super.key, required this.sensorData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Capteurs 📊',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSensorCard(
              title: 'Température',
              value: '${sensorData.temperature.toStringAsFixed(1)}°C',
              icon: Icons.thermostat,
              color: Colors.orange,
              gradient: LinearGradient(
                colors: [Colors.orange[400]!, Colors.orange[600]!],
              ),
            ),
            const SizedBox(height: 16),
            _buildSensorCard(
              title: 'Humidité Air',
              value: '${sensorData.humidityAir}%',
              icon: Icons.air,
              color: Colors.blue,
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[600]!],
              ),
            ),
            const SizedBox(height: 16),
            _buildSensorCard(
              title: 'Humidité Sol',
              value: '${sensorData.humiditySoil}%',
              icon: Icons.grass,
              color: Colors.brown,
              gradient: LinearGradient(
                colors: [Colors.brown[400]!, Colors.brown[600]!],
              ),
            ),
            const SizedBox(height: 16),
            _buildSensorCard(
              title: 'Prévision Pluie',
              value: '${sensorData.rainForecast} mm',
              icon: Icons.water_drop,
              color: Colors.indigo,
              gradient: LinearGradient(
                colors: [Colors.indigo[400]!, Colors.indigo[600]!],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Données mises à jour en temps réel depuis ESP32',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Gradient gradient,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 36,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
