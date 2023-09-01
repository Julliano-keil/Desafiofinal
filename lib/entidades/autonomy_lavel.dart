class AutonomyLevel {
  final int? id;
  final String name;
  final double networkSecurity;
  final double storePercentage;
  final double networkPercentage;

  AutonomyLevel({
    this.id,
    required this.name,
    required this.networkSecurity,
    required this.storePercentage,
    required this.networkPercentage,
  });
}
