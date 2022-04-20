class Product {
  late final String name;
  late final double price;
  late final String imageURL;
  late final String brandName;
  late final int quantitiy;
  late final String description;
  late final dynamic size;
  Product(
      {required this.name,
      required this.price,
      required this.imageURL,
      required this.brandName,
      required this.quantitiy,
      required this.description,
      required this.size});

  static List<Product> products = <Product>[];
}
