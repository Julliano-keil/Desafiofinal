class Vehicle {
  final int? id;
  final String model;
  final String brand;
  final String yearManufacture;
  final String yearVehicle;
  final String? image;
  final double pricePaidShop;
  final String purchaseDate;
  final int? idperson;
  final String nameUser;
  bool favorite = false;

  Vehicle(
      {this.id,
      this.idperson,
      required this.nameUser,
      required this.model,
      required this.brand,
      required this.yearManufacture,
      required this.yearVehicle,
      required this.image,
      required this.pricePaidShop,
      required this.purchaseDate});
}
