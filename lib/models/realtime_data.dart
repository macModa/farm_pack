import 'sensor_data.dart';
import 'plant.dart';

class RealtimeData {
  final SensorData sensorData;
  final List<Plant> plants;

  RealtimeData({
    required this.sensorData,
    required this.plants,
  });

  factory RealtimeData.fromJson(Map<String, dynamic> json) {
    var plantsList = json['plants'] as List? ?? [];
    List<Plant> plants = plantsList
        .map((plant) => Plant.fromJson(plant))
        .toList();

    return RealtimeData(
      sensorData: SensorData.fromJson(json['sensor_data'] ?? {}),
      plants: plants,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensor_data': sensorData.toJson(),
      'plants': plants.map((plant) => plant.toJson()).toList(),
    };
  }
}
