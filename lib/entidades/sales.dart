/// Represents a sale transaction.
class Sale {
  /// The unique identifier for this sale.
  final int? id;

  /// The CPF (Cadastro de Pessoas Físicas) of the
  /// customer involved in the sale.
  final String customerCpf;

  /// The name of the customer involved in the sale.
  final String customerName;

  /// The date and time when the sale occurred.
  final String soldWhen;

  /// The price at which the sale was made.
  final double priceSold;

  /// The percentage associated with the dealership in the sale.
  final double dealershipPercentage;

  /// The percentage associated with the business in the sale.
  final double businessPercentage;

  /// The safety-related percentage in the sale.
  final double safetyPercentage;

  /// The unique identifier of the vehicle involved in the sale.
  final int vehicleId;

  /// The name of the user involved in the sale.
  final String nameUser;

  /// The brand of the vehicle involved in the sale.
  final String brand;

  /// The model of the vehicle involved in the sale.
  final String model;

  /// The CNPJ (Cadastro Nacional da Pessoa Jurídica) of the user involved
  ///  in the sale.
  final String userCnpj;

  /// The user ID involved in the sale.
  final int userId;

  /// The license plate of the vehicle involved in the sale.
  final String plate;

  /// Constructor for creating a Sale instance.
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
