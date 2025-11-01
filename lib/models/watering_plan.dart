class WateringPlan {
  final String day;
  final int durationMin;
  final double quantityL;

  WateringPlan({
    required this.day,
    required this.durationMin,
    required this.quantityL,
  });

  factory WateringPlan.fromJson(Map<String, dynamic> json) {
    return WateringPlan(
      day: json['day'] ?? '',
      durationMin: json['duration_min'] ?? 0,
      quantityL: (json['quantityL'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'duration_min': durationMin,
      'quantityL': quantityL,
    };
  }
}
