import 'package:order_app/model/product.dart';

class OrderItem {
  final Product product;
  int count;

  OrderItem({
    required this.product,
    this.count = 0,
  });
}
