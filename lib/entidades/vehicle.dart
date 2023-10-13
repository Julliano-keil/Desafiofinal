/// Represents a vehicle.
class Vehicle {
  /// The unique identifier for this vehicle.
  final int? id;

  /// The model of the vehicle.
  final String model;

  /// The brand of the vehicle.
  final String brand;

  /// The year of manufacture for the vehicle.
  final String yearManufacture;

  /// The year of the vehicle.
  final String yearVehicle;

  /// The image associated with the vehicle (can be null).
  final String? image;

  /// The price paid for the vehicle at the shop.
  final double pricePaidShop;

  /// The date when the vehicle was purchased.
  final String purchaseDate;

  /// The unique identifier of the person associated
  /// with the vehicle (can be null).
  final int? idperson;

  /// The name of the user associated with the vehicle.
  final String nameUser;

  /// Indicates whether the vehicle is marked as a favorite (initially false).
  bool favorite = false;

  /// Constructor for creating a Vehicle instance.
  Vehicle({
    this.id,
    this.idperson,
    required this.nameUser,
    required this.model,
    required this.brand,
    required this.yearManufacture,
    required this.yearVehicle,
    required this.image,
    required this.pricePaidShop,
    required this.purchaseDate,
  });
}
