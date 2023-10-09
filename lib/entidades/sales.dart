// Constructor for the Sale object
class Sale {
  final int? id;
  final String customerCpf;
  final String customerName;
  final String soldWhen;
  final double priceSold;
  final double dealershipPercentage;
  final double businessPercentage;
  final double safetyPercentage;
  final int vehicleId;
  final String nameUser;
  final String brand;
  final String model;
  final String userCnpj;
  final int userId;
  final String plate;

  Sale({
    this.id,
    required this.plate,
    required this.brand,
    required this.userCnpj,
    required this.model,
    required this.nameUser,
    required this.customerCpf,
    required this.customerName,
    required this.soldWhen,
    required this.priceSold,
    required this.dealershipPercentage,
    required this.businessPercentage,
    required this.safetyPercentage,
    required this.vehicleId,
    required this.userId,
  });

  @override
  String toString() {
    return 'Vehicle sold to $customerName at $soldWhen';
  }
}
