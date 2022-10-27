import 'package:order_app/model/product.dart';

abstract class BaseProductRepository {
  Future<List<Product>> index();
}
