import 'product_model.dart';

class Order {
  late final int orderNumber;
  late final String customerID; // uid
  late final List<Product> products;
  late final double totalPrice;
  late final DateTime orderDate;
  Order(
      {required this.orderNumber,
      required this.customerID,
      required this.products,
      required this.totalPrice,
      required this.orderDate});
}
