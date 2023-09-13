class VehicleModel {
  List<String> imagesUrl;
  String name;
  List<String> tags;
  String description;
  String available;
  String price;
  int priceRank;

  VehicleModel({
    required this.imagesUrl,
    required this.name,
    required this.tags,
    required this.description,
    required this.available,
    required this.price,
    required this.priceRank,
  });

  String get getPriceText {
    String priceText = '';
    switch (priceRank) {
      case 5:
        priceText = 'Best Price';
        break;
      case 4:
        priceText = 'Good Price';
        break;
      case 3:
        priceText = 'Average Price';
        break;
      case 2:
        priceText = 'Below the average Price';
        break;
      default:
        priceText = 'Bad Price';
    }

    return priceText;
  }

  @override
  bool operator ==(Object other) =>
      other is VehicleModel &&
      imagesUrl == other.imagesUrl &&
      name == other.name &&
      tags == other.tags &&
      description == other.description &&
      available == other.available &&
      price == other.price &&
      priceRank == other.priceRank;

  @override
  int get hashCode => Object.hash(
        imagesUrl,
        name,
        tags,
        description,
        available,
        price,
        priceRank,
      );
}
