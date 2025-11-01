import 'watering_plan.dart';

class Plant {
  final String name;
  final String category;
  final String waterNeed;
  final String soilType;
  final String region;
  final List<WateringPlan> wateringPlan;

  Plant({
    required this.name,
    required this.category,
    required this.waterNeed,
    required this.soilType,
    required this.region,
    required this.wateringPlan,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    var wateringList = json['watering_plan'] as List? ?? [];
    List<WateringPlan> plans = wateringList
        .map((plan) => WateringPlan.fromJson(plan))
        .toList();

    return Plant(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      waterNeed: json['water_need'] ?? '',
      soilType: json['soilType'] ?? '',
      region: json['region'] ?? '',
      wateringPlan: plans,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'water_need': waterNeed,
      'soilType': soilType,
      'region': region,
      'watering_plan': wateringPlan.map((plan) => plan.toJson()).toList(),
    };
  }
}
