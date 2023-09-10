class Vehicle {
  final int? id;
  final String model;
  final String brand;
  final int yearManufacture;
  final int yearVehicle;
  final String image;
  final double pricePaidShop;
  final String purchaseDate;
  bool favorite = false;

  Vehicle(
      {this.id,
      required this.model,
      required this.brand,
      required this.yearManufacture,
      required this.yearVehicle,
      required this.image,
      required this.pricePaidShop,
      required this.purchaseDate});
}
